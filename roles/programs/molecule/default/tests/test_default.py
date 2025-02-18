def test_program_installed(host):
    program = host.package("neovim")
    assert program.is_installed
