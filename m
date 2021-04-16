Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A09362841
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbhDPTHH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Apr 2021 15:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235877AbhDPTHH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Apr 2021 15:07:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7047613B4;
        Fri, 16 Apr 2021 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618600002;
        bh=Au3M8d9TGedy6ttuMVhUpPPMGyWlvqWqr5/wBGPaMEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AD9t9Y+nIAvbHoRtCskbByoW7dl+Ic+4Fo3LrDOk7/0KUaHAWtpgylOQjrZ8wJR9a
         dvsKq5+hc4mKwIN0yRrikBHerohRykSHJhzJ76HyNFZrC67csHntrV8SPGPF6vMBFc
         uOqtzH0EZ+bXFwKqv6QW07ggZsg6yjbMOz6MOR4edButYYOxFfbzPrZIpo5RW5t+j7
         tD3Ea5b2adrP1XzEcwso/gtv+im3oqjJvtQlsGSaWVD1I+H2Voaqdp/ra+IV33qWoB
         vlrnmDMDJvlaOWw8ERoGiDtowp73xi4jh+qEnF2gQV+2oOMv/w728C1kc/7a4zz/GL
         piEIFl0HB7BsA==
Date:   Fri, 16 Apr 2021 14:06:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, amurray@thegoodpenguin.co.uk, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20210416190640.GA2743067@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416134537.19474-1-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 16, 2021 at 07:15:37PM +0530, Vidya Sagar wrote:
> The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
> With the current hardware design limitations in place, ECAM can be enabled
> only for one controller (C5 controller to be precise) with bus numbers
> starting from 160 instead of 0. A different approach is taken to avoid this
> abnormal way of enabling ECAM for just one controller but to enable
> configuration space access for all the other controllers. In this approach,
> ops are added through MCFG quirk mechanism which access the configuration
> spaces by dynamically programming iATU (internal AddressTranslation Unit)
> to generate respective configuration accesses just like the way it is
> done in DesignWare core sub-system.
> This issue is specific to Tegra194 and it would be fixed in the future
> generations of Tegra SoCs.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Applied to pci/tegra for v5.13, thanks!

> ---
> V4:
> * Addressed Bjorn's review comments
> * Rebased changes on top of Lorenzo's pci/dwc branch
> 
> V3:
> * Removed MCFG address hardcoding in pci_mcfg.c file
> * Started using 'dbi_base' for accessing root port's own config space
> * and using 'config_base' for accessing config space of downstream hierarchy
> 
> V2:
> * Fixed build issues reported by kbuild test bot
> 
>  drivers/acpi/pci_mcfg.c                    |   7 ++
>  drivers/pci/controller/dwc/Makefile        |   2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 103 +++++++++++++++++++++
>  include/linux/pci-ecam.h                   |   1 +
>  4 files changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 95f23acd5b80..53cab975f612 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -116,6 +116,13 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	THUNDER_ECAM_QUIRK(2, 12),
>  	THUNDER_ECAM_QUIRK(2, 13),
>  
> +	{ "NVIDIA", "TEGRA194", 1, 0, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 1, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 2, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 3, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 4, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +	{ "NVIDIA", "TEGRA194", 1, 5, MCFG_BUS_ANY, &tegra194_pcie_ops},
> +
>  #define XGENE_V1_ECAM_MCFG(rev, seg) \
>  	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
>  		&xgene_v1_pcie_ecam_ops }
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 625f6aaeb5b8..2da826ef18ac 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>  obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>  obj-$(CONFIG_PCI_MESON) += pci-meson.o
> -obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  
> @@ -35,4 +34,5 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_ARM64) += pcie-al.o
>  obj-$(CONFIG_ARM64) += pcie-hisi.o
> +obj-$(CONFIG_ARM64) += pcie-tegra194.o
>  endif
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6fa216e52d14..cb38e94a3033 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -22,6 +22,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> @@ -311,6 +313,104 @@ struct tegra_pcie_dw_of_data {
>  	enum dw_pcie_device_mode mode;
>  };
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +struct tegra194_pcie_ecam  {
> +	void __iomem *config_base;
> +	void __iomem *iatu_base;
> +	void __iomem *dbi_base;
> +};
> +
> +static int tegra194_acpi_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct tegra194_pcie_ecam *pcie_ecam;
> +
> +	pcie_ecam = devm_kzalloc(dev, sizeof(*pcie_ecam), GFP_KERNEL);
> +	if (!pcie_ecam)
> +		return -ENOMEM;
> +
> +	pcie_ecam->config_base = cfg->win;
> +	pcie_ecam->iatu_base = cfg->win + SZ_256K;
> +	pcie_ecam->dbi_base = cfg->win + SZ_512K;
> +	cfg->priv = pcie_ecam;
> +
> +	return 0;
> +}
> +
> +static void atu_reg_write(struct tegra194_pcie_ecam *pcie_ecam, int index,
> +			  u32 val, u32 reg)
> +{
> +	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> +
> +	writel(val, pcie_ecam->iatu_base + offset + reg);
> +}
> +
> +static void program_outbound_atu(struct tegra194_pcie_ecam *pcie_ecam,
> +				 int index, int type, u64 cpu_addr,
> +				 u64 pci_addr, u64 size)
> +{
> +	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr),
> +		      PCIE_ATU_LOWER_BASE);
> +	atu_reg_write(pcie_ecam, index, upper_32_bits(cpu_addr),
> +		      PCIE_ATU_UPPER_BASE);
> +	atu_reg_write(pcie_ecam, index, lower_32_bits(pci_addr),
> +		      PCIE_ATU_LOWER_TARGET);
> +	atu_reg_write(pcie_ecam, index, lower_32_bits(cpu_addr + size - 1),
> +		      PCIE_ATU_LIMIT);
> +	atu_reg_write(pcie_ecam, index, upper_32_bits(pci_addr),
> +		      PCIE_ATU_UPPER_TARGET);
> +	atu_reg_write(pcie_ecam, index, type, PCIE_ATU_CR1);
> +	atu_reg_write(pcie_ecam, index, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> +}
> +
> +static void __iomem *tegra194_map_bus(struct pci_bus *bus,
> +				      unsigned int devfn, int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct tegra194_pcie_ecam *pcie_ecam = cfg->priv;
> +	u32 busdev;
> +	int type;
> +
> +	if (bus->number < cfg->busr.start || bus->number > cfg->busr.end)
> +		return NULL;
> +
> +	if (bus->number == cfg->busr.start) {
> +		if (PCI_SLOT(devfn) == 0)
> +			return pcie_ecam->dbi_base + where;
> +		else
> +			return NULL;
> +	}
> +
> +	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> +		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> +
> +	if (bus->parent->number == cfg->busr.start) {
> +		if (PCI_SLOT(devfn) == 0)
> +			type = PCIE_ATU_TYPE_CFG0;
> +		else
> +			return NULL;
> +	} else {
> +		type = PCIE_ATU_TYPE_CFG1;
> +	}
> +
> +	program_outbound_atu(pcie_ecam, 0, type, cfg->res.start, busdev,
> +			     SZ_256K);
> +
> +	return pcie_ecam->config_base + where;
> +}
> +
> +const struct pci_ecam_ops tegra194_pcie_ops = {
> +	.init		= tegra194_acpi_init,
> +	.pci_ops	= {
> +		.map_bus	= tegra194_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> +
> +#ifdef CONFIG_PCIE_TEGRA194
> +
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>  {
>  	return container_of(pci, struct tegra_pcie_dw, pci);
> @@ -2311,3 +2411,6 @@ MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
>  MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
>  MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
>  MODULE_LICENSE("GPL v2");
> +
> +#endif /* CONFIG_PCIE_TEGRA194 */
> +
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 65d3d83015c3..fbdadd4d8377 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -85,6 +85,7 @@ extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
>  extern const struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
>  extern const struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>  extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
> +extern const struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
>  #endif
>  
>  #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
> -- 
> 2.17.1
> 
