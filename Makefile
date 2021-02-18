TESTS := test__aes256_fifo test__words_block test__crypto_accel_axi
HDL := \
	hdl/aes_256.v \
	hdl/aes256_fifo.v \
	hdl/crypto-accel.v \
	hdl/fifo.v \
	hdl/key_ram.v \
	hdl/round.v \
	hdl/shift_reg.v \
	hdl/simple_dpram_sclk.v \
	hdl/table.v \
	hdl/word_block.v

TEST_BUILD_DIR := stimulus/build

.PHONY : test clean

TESTS_FULL := $(addprefix $(TEST_BUILD_DIR)/,$(TESTS))
test : $(TESTS_FULL)

$(TEST_BUILD_DIR)/.exists :
	mkdir -p $(TEST_BUILD_DIR)
	touch $@

$(TESTS_FULL) : $(TEST_BUILD_DIR)/% : stimulus/%.v $(TEST_BUILD_DIR)/.exists $(HDL)
	iverilog -I stimulus/ $< $(HDL) -o $@

clean :
	rm -rf $(TEST_BUILD_DIR)