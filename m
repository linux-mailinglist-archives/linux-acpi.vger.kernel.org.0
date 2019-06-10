Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE63B09D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2019 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfFJIUG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Jun 2019 04:20:06 -0400
Received: from foss.arm.com ([217.140.110.172]:37858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387825AbfFJIUG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jun 2019 04:20:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8570344;
        Mon, 10 Jun 2019 01:20:04 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408013F246;
        Mon, 10 Jun 2019 01:20:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] irqchip/gic: Add support for Amazon Graviton variant
 of GICv3+GICv2m
To:     Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     benh@kernel.crashing.org, ronenk@amazon.com,
        Hanna Hawa <hhhawa@amazon.com>,
        "Aerov, Vladimir" <vaerov@amazon.com>, barakw@amazon.com,
        dwmw@amazon.co.uk, jonnyc@amazon.com, hanochu@amazon.com,
        talel@amazon.com
References: <7f74e9e2-83d4-a69b-aef8-4964b3e43745@amazon.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 mQINBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABtCNNYXJjIFp5bmdp
 ZXIgPG1hcmMuenluZ2llckBhcm0uY29tPokCTwQTAQIAOQIbAwYLCQgHAwIGFQgCCQoLBBYC
 AwECHgECF4AWIQSf1RxT4LVjGP2VnD0j0NC60T16QwUCXO+WxgAKCRAj0NC60T16QzfuEACd
 oPsSJdUg3nm61VKq86Pp0mfCC5IVyD/vTDw3jDErsmtT7t8mMVgidSJe9cMEudLO5xske/mY
 sC7ZZ4GFNRRsFs3wY5g+kg4yk2UY6q18HXRQJwzWCug2bkJPUxbh71nS3KPsvq4BBOeQiTIX
 Xr0lTyReFAp+JZ0HpanAU/iD2usEZLDNLXYLRjaHlfkwouxt02XcTKbqRWNtKl3Ybj+mz5IA
 qEQnA5Z8Nt9ZQmlZ4ASiXVVCbZKIR3RewBL6BP4OhYrvcPCtkoqlqKWZoHBs3ZicRXvcVUr/
 nqUyZpqhmfht2mIE063L3kTfBqxJ1SQqPc0ZIModTh4ATEjC44x8ObQvtnmgL8EKJBhxJfjY
 EUYLnwSejH1h+qgj94vn7n1RMVqXpCrWHyF7pCDBqq3gBxtDu6TWgi4iwh4CtdOzXBw2V39D
 LlnABnrZl5SdVbRwV+Ek1399s/laceH8e4uNea50ho89WmP9AUCrXlawHohfDE3GMOV4BdQ2
 DbJAtZnENQXaRK9gr86jbGQBga9VDvsBbRd+uegEmQ8nPspryWIz/gDRZLXIG8KE9Jj9OhwE
 oiusVTLsw7KS4xKDK2Ixb/XGtJPLtUXbMM1n9YfLsB5JPZ3B08hhrv+8Vmm734yCXtxI0+7B
 F1V4T2njuJKWTsmJWmx+tIY8y9muUK9rabkCDQROiX9FARAAz/al0tgJaZ/eu0iI/xaPk3DK
 NIvr9SsKFe2hf3CVjxriHcRfoTfriycglUwtvKvhvB2Y8pQuWfLtP9Hx3H+YI5a78PO2tU1C
 JdY5Momd3/aJBuUFP5blbx6n+dLDepQhyQrAp2mVC3NIp4T48n4YxL4Og0MORytWNSeygISv
 Rordw7qDmEsa7wgFsLUIlhKmmV5VVv+wAOdYXdJ9S8n+XgrxSTgHj5f3QqkDtT0yG8NMLLmY
 kZpOwWoMumeqn/KppPY/uTIwbYTD56q1UirDDB5kDRL626qm63nF00ByyPY+6BXH22XD8smj
 f2eHw2szECG/lpD4knYjxROIctdC+gLRhz+Nlf8lEHmvjHgiErfgy/lOIf+AV9lvDF3bztjW
 M5oP2WGeR7VJfkxcXt4JPdyDIH6GBK7jbD7bFiXf6vMiFCrFeFo/bfa39veKUk7TRlnX13go
 gIZxqR6IvpkG0PxOu2RGJ7Aje/SjytQFa2NwNGCDe1bH89wm9mfDW3BuZF1o2+y+eVqkPZj0
 mzfChEsiNIAY6KPDMVdInILYdTUAC5H26jj9CR4itBUcjE/tMll0n2wYRZ14Y/PM+UosfAhf
 YfN9t2096M9JebksnTbqp20keDMEBvc3KBkboEfoQLU08NDo7ncReitdLW2xICCnlkNIUQGS
 WlFVPcTQ2sMAEQEAAYkCHwQYAQIACQUCTol/RQIbDAAKCRAj0NC60T16QwsFD/9T4y30O0Wn
 MwIgcU8T2c2WwKbvmPbaU2LDqZebHdxQDemX65EZCv/NALmKdA22MVSbAaQeqsDD5KYbmCyC
 czilJ1i+tpZoJY5kJALHWWloI6Uyi2s1zAwlMktAZzgGMnI55Ifn0dAOK0p8oy7/KNGHNPwJ
 eHKzpHSRgysQ3S1t7VwU4mTFJtXQaBFMMXg8rItP5GdygrFB7yUbG6TnrXhpGkFBrQs9p+SK
 vCqRS3Gw+dquQ9QR+QGWciEBHwuSad5gu7QC9taN8kJQfup+nJL8VGtAKgGr1AgRx/a/V/QA
 ikDbt/0oIS/kxlIdcYJ01xuMrDXf1jFhmGZdocUoNJkgLb1iFAl5daV8MQOrqciG+6tnLeZK
 HY4xCBoigV7E8KwEE5yUfxBS0yRreNb+pjKtX6pSr1Z/dIo+td/sHfEHffaMUIRNvJlBeqaj
 BX7ZveskVFafmErkH7HC+7ErIaqoM4aOh/Z0qXbMEjFsWA5yVXvCoJWSHFImL9Bo6PbMGpI0
 9eBrkNa1fd6RGcktrX6KNfGZ2POECmKGLTyDC8/kb180YpDJERN48S0QBa3Rvt06ozNgFgZF
 Wvu5Li5PpY/t/M7AAkLiVTtlhZnJWyEJrQi9O2nXTzlG1PeqGH2ahuRxn7txA5j5PHZEZdL1
 Z46HaNmN2hZS/oJ69c1DI5Rcww==
Organization: ARM Ltd
Message-ID: <ed046542-a3cd-87e3-6d43-c5a13e56e18a@arm.com>
Date:   Mon, 10 Jun 2019 09:20:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7f74e9e2-83d4-a69b-aef8-4964b3e43745@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Zeev,

On 07/06/2019 00:17, Zeev Zilberman wrote:
> The patch adds support for Amazon Graviton custom variant of GICv2m, where
> hw irq is encoded using the MSI message address, as opposed to standard
> GICv2m, where hw irq is encoded in the MSI message data.
> In addition, the Graviton flavor of GICv2m is used along GICv3 (and not
> GICv2).
> 
> Signed-off-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

There seem to be some confusion about who is the author of this patch.
As you're the one posting the patch, your SoB tag should be the last
one. And assuming the patch has been developed together with Ben, it
should read:

Co-developed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Zeev Zilberman <zeev@amazon.com>

> ---
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index 3c77ab6..eeed19f 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -56,6 +56,7 @@
>  
>  /* List of flags for specific v2m implementation */
>  #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
> +#define GICV2M_GRAVITON_ADDRESS_ONLY	0x00000002
>  
>  static LIST_HEAD(v2m_nodes);
>  static DEFINE_SPINLOCK(v2m_lock);
> @@ -98,15 +99,26 @@ static struct msi_domain_info gicv2m_msi_domain_info = {
>  	.chip	= &gicv2m_msi_irq_chip,
>  };
>  
> +static phys_addr_t gicv2m_get_msi_addr(struct v2m_data *v2m, int hwirq)
> +{
> +	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
> +		return v2m->res.start | ((hwirq - 32) << 3);
> +	else
> +		return v2m->res.start + V2M_MSI_SETSPI_NS;
> +}
> +
>  static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
> -	phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
> +	phys_addr_t addr = gicv2m_get_msi_addr(v2m, data->hwirq);
>  
>  	msg->address_hi = upper_32_bits(addr);
>  	msg->address_lo = lower_32_bits(addr);
> -	msg->data = data->hwirq;
>  
> +	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
> +		msg->data = 0;
> +	else
> +		msg->data = data->hwirq;
>  	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
>  		msg->data -= v2m->spi_offset;
>  
> @@ -188,7 +200,7 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	hwirq = v2m->spi_start + offset;
>  
>  	err = iommu_dma_prepare_msi(info->desc,
> -				    v2m->res.start + V2M_MSI_SETSPI_NS);
> +				    gicv2m_get_msi_addr(v2m, hwirq));
>  	if (err)
>  		return err;
>  
> @@ -307,7 +319,7 @@ static int gicv2m_allocate_domains(struct irq_domain *parent)
>  
>  static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>  				  u32 spi_start, u32 nr_spis,
> -				  struct resource *res)
> +				  struct resource *res, u32 flags)
>  {
>  	int ret;
>  	struct v2m_data *v2m;
> @@ -320,6 +332,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>  
>  	INIT_LIST_HEAD(&v2m->entry);
>  	v2m->fwnode = fwnode;
> +	v2m->flags = flags;
>  
>  	memcpy(&v2m->res, res, sizeof(struct resource));
>  
> @@ -334,7 +347,14 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>  		v2m->spi_start = spi_start;
>  		v2m->nr_spis = nr_spis;
>  	} else {
> -		u32 typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
> +		u32 typer;
> +
> +		/* Graviton should always have explicit spi_start/nr_spis */
> +		if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY) {
> +			ret = -EINVAL;
> +			goto err_iounmap;
> +		}
> +		typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
>  
>  		v2m->spi_start = V2M_MSI_TYPER_BASE_SPI(typer);
>  		v2m->nr_spis = V2M_MSI_TYPER_NUM_SPI(typer);
> @@ -355,18 +375,21 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
>  	 *
>  	 * Broadom NS2 GICv2m implementation has an erratum where the MSI data
>  	 * is 'spi_number - 32'
> +	 *
> +	 * Reading that register fails on the Graviton implementation
>  	 */
> -	switch (readl_relaxed(v2m->base + V2M_MSI_IIDR)) {
> -	case XGENE_GICV2M_MSI_IIDR:
> -		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
> -		v2m->spi_offset = v2m->spi_start;
> -		break;
> -	case BCM_NS2_GICV2M_MSI_IIDR:
> -		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
> -		v2m->spi_offset = 32;
> -		break;
> +	if (!(v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)) {
> +		switch (readl_relaxed(v2m->base + V2M_MSI_IIDR)) {
> +		case XGENE_GICV2M_MSI_IIDR:
> +			v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
> +			v2m->spi_offset = v2m->spi_start;
> +			break;
> +		case BCM_NS2_GICV2M_MSI_IIDR:
> +			v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
> +			v2m->spi_offset = 32;
> +			break;
> +		}
>  	}
> -
>  	v2m->bm = kcalloc(BITS_TO_LONGS(v2m->nr_spis), sizeof(long),
>  			  GFP_KERNEL);
>  	if (!v2m->bm) {
> @@ -419,7 +442,8 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
>  			pr_info("DT overriding V2M MSI_TYPER (base:%u, num:%u)\n",
>  				spi_start, nr_spis);
>  
> -		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis, &res);
> +		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
> +				      &res, 0);
>  		if (ret) {
>  			of_node_put(child);
>  			break;
> @@ -451,6 +475,29 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
>  	return data->fwnode;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static bool acpi_check_amazon_graviton_quirks(void)
> +{
> +	static struct acpi_table_madt *madt;
> +	acpi_status status;
> +	bool rc = false;
> +
> +#define ACPI_AMZN_OEM_ID		"AMAZON"
> +
> +	status = acpi_get_table(ACPI_SIG_MADT, 0,
> +				(struct acpi_table_header **)&madt);
> +
> +	if (ACPI_FAILURE(status) || !madt)
> +		return rc;
> +	rc = !memcmp(madt->header.oem_id, ACPI_AMZN_OEM_ID, ACPI_OEM_ID_SIZE);
> +	acpi_put_table((struct acpi_table_header *)madt);
> +
> +	return rc;
> +}
> +#else
> +static inline bool acpi_check_amazon_graviton_quirks(void) { return false; }
> +#endif

Aren't you already in a #ifdef CONFIG_ACPI block here? You could loose
the #ifdefery altogether.

> +
>  static int __init
>  acpi_parse_madt_msi(union acpi_subtable_headers *header,
>  		    const unsigned long end)
> @@ -460,6 +507,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
>  	u32 spi_start = 0, nr_spis = 0;
>  	struct acpi_madt_generic_msi_frame *m;
>  	struct fwnode_handle *fwnode;
> +	u32 flags = 0;
>  
>  	m = (struct acpi_madt_generic_msi_frame *)header;
>  	if (BAD_MADT_ENTRY(m, end))
> @@ -469,6 +517,13 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
>  	res.end = m->base_address + SZ_4K - 1;
>  	res.flags = IORESOURCE_MEM;
>  
> +	if (acpi_check_amazon_graviton_quirks()) {
> +		pr_info("applying Amazon Graviton quirk\n");
> +		res.end = res.start + SZ_8K - 1;
> +		flags |= GICV2M_GRAVITON_ADDRESS_ONLY;
> +		gicv2m_msi_domain_info.flags &= ~MSI_FLAG_MULTI_PCI_MSI;
> +	}
> +
>  	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
>  		spi_start = m->spi_base;
>  		nr_spis = m->spi_count;
> @@ -483,7 +538,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
>  		return -EINVAL;
>  	}
>  
> -	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
> +	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res, flags);
>  	if (ret)
>  		irq_domain_free_fwnode(fwnode);
>  
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index f44cd89..1282f81 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1343,6 +1343,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  	if (gic_dist_supports_lpis()) {
>  		its_init(handle, &gic_data.rdists, gic_data.domain);
>  		its_cpu_init();
> +	} else {
> +		if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
> +			gicv2m_init(handle, gic_data.domain);
>  	}
>  
>  	if (gic_prio_masking_enabled()) {
> diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
> index 9a1a479..62a8821 100644
> --- a/include/linux/irqchip/arm-gic-common.h
> +++ b/include/linux/irqchip/arm-gic-common.h
> @@ -39,4 +39,9 @@ struct gic_kvm_info {
>  
>  const struct gic_kvm_info *gic_get_kvm_info(void);
>  
> +struct irq_domain;
> +struct fwnode_handle;
> +int gicv2m_init(struct fwnode_handle *parent_handle,
> +		struct irq_domain *parent);
> +
>  #endif /* __LINUX_IRQCHIP_ARM_GIC_COMMON_H */
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 0f049b3..7bd3bc6 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -160,9 +160,6 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
>   */
>  void gic_init(void __iomem *dist , void __iomem *cpu);
>  
> -int gicv2m_init(struct fwnode_handle *parent_handle,
> -		struct irq_domain *parent);
> -
>  void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
>  int gic_get_cpu_id(unsigned int cpu);
>  void gic_migrate_target(unsigned int new_cpu_id);
> 

Otherwise, looks OK to me. If you repost it with the couple of nits
above fixed, I'll take it into -next for a bit of a soak test.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
