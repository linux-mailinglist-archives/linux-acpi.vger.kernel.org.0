Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7BC681FC2
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Jan 2023 00:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjA3Xiy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 18:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjA3Xix (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 18:38:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8742B61B
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 15:38:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q5so12757356wrv.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 15:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0D2OAkoPSuqGKjYfRL/XBDXMIK40xEQA3Iqq9uVH7g=;
        b=WNM+LzlDInSIM5aAM0uVfSzBnlnhI/kYDKYv5CNfmyIolHk9byTBwn8hNONJ458Cay
         bZ9Jh/qgcbj8wXhylJWvOFPtm06jFcgcdKZktxHVThzvXSr6mMLV3vk5Xt3p9C20khjb
         KUS/jzF3LNa/VAZMBQWpJBNOPWQYqdXyzPmzEivpTUaKthQkq4Zv6vN3gKjC30bAId0e
         q+YN1i3wGluxuqNaCbYHi2JLfL0Oju/PdPt0vbeRiJYdkTgB1qvRK+BwBee/O2HcAFTr
         u3wqgWnn6DVfyIuCib0tK2Cs56yqZYtBKsBSODr4CKIDAb6TxrLnWo6+oxDGlKIl1Rcm
         DaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0D2OAkoPSuqGKjYfRL/XBDXMIK40xEQA3Iqq9uVH7g=;
        b=yAZFQZreGTDagZDyYYPjBzPF8WXzZWInVbcT2O6560y6RnI5iPqhUqNrgBu5+uf4Hv
         cj+Wl+yI58InBOl2SCr0hZxrEoAu8MFk3hN9IqH/0zhUm89Z8teNB2NGzkznZZq9x7MT
         +TAN9DnlRZpzy8xmUDbXxD2XL9cAsxzfLKcY+LZ/iWl8FpeQAfygqo7Eg+yS8ySRz2SA
         DfPjVQf30/Vr+htAAMqAUVVkdrhARzDw3lnmmiuhZV8UAmeCZHIufQV75tWNjAP+tFg+
         OCzvC8ipXEMQpaRoSRxCQRfi5ormAIkLsEcvpv3HiKdDFWYWEg9StVo9KhMG4M+bIrTG
         GV7A==
X-Gm-Message-State: AO0yUKWRP6sO3/jBJQ7ShW4a0JvZ+fZi2AH58jc+hiHVatD86PWjPM3F
        XnyFhzVgHfpRMjOX6a6qzoF/0Q==
X-Google-Smtp-Source: AK7set+th+iU4+VT+YyfX3TofjLEq/2pqNCe2nCL1a5FI7ePffNwYAI1KUnTm18azN07is2Is689Tg==
X-Received: by 2002:adf:e702:0:b0:2bf:b765:7a13 with SMTP id c2-20020adfe702000000b002bfb7657a13mr1001880wrm.5.1675121930175;
        Mon, 30 Jan 2023 15:38:50 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id o6-20020adfe806000000b002bdf8dd6a8bsm12909713wrm.80.2023.01.30.15.38.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:38:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 11/24] RISC-V: ACPI: irqchip/riscv-intc: Add ACPI support
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230130182225.2471414-12-sunilvl@ventanamicro.com>
Date:   Mon, 30 Jan 2023 23:38:49 +0000
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFDD5897-27A3-4418-B08B-9650B543692D@jrtc27.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-12-sunilvl@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 30 Jan 2023, at 18:22, Sunil V L <sunilvl@ventanamicro.com> wrote:
>=20
> Add support for initializing the RISC-V INTC driver on ACPI based
> platforms.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
> drivers/irqchip/irq-riscv-intc.c | 79 +++++++++++++++++++++++++++-----
> 1 file changed, 67 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-riscv-intc.c =
b/drivers/irqchip/irq-riscv-intc.c
> index f229e3e66387..044ec92fcba7 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -6,6 +6,7 @@
>  */
>=20
> #define pr_fmt(fmt) "riscv-intc: " fmt
> +#include <linux/acpi.h>
> #include <linux/atomic.h>
> #include <linux/bits.h>
> #include <linux/cpu.h>
> @@ -112,6 +113,30 @@ static struct fwnode_handle =
*riscv_intc_hwnode(void)
> 	return intc_domain->fwnode;
> }
>=20
> +static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> +{
> +	int rc;
> +
> +	intc_domain =3D irq_domain_create_linear(fn, BITS_PER_LONG,
> +					       &riscv_intc_domain_ops, =
NULL);
> +	if (!intc_domain) {
> +		pr_err("unable to add IRQ domain\n");
> +		return -ENXIO;
> +	}
> +
> +	rc =3D set_handle_irq(&riscv_intc_irq);
> +	if (rc) {
> +		pr_err("failed to set irq handler\n");
> +		return rc;
> +	}
> +
> +	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> +
> +	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +
> +	return 0;
> +}
> +
> static int __init riscv_intc_init(struct device_node *node,
> 				  struct device_node *parent)
> {
> @@ -133,24 +158,54 @@ static int __init riscv_intc_init(struct =
device_node *node,
> 	if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
> 		return 0;
>=20
> -	intc_domain =3D irq_domain_add_linear(node, BITS_PER_LONG,
> -					    &riscv_intc_domain_ops, =
NULL);
> -	if (!intc_domain) {
> -		pr_err("unable to add IRQ domain\n");
> -		return -ENXIO;
> -	}
> -
> -	rc =3D set_handle_irq(&riscv_intc_irq);
> +	rc =3D riscv_intc_init_common(of_node_to_fwnode(node));
> 	if (rc) {
> -		pr_err("failed to set irq handler\n");
> +		pr_err("failed to initialize INTC\n");
> 		return rc;
> 	}
>=20
> -	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> +	return 0;
> +}
>=20
> -	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +
> +#ifdef CONFIG_ACPI
> +
> +static int __init
> +riscv_intc_acpi_init(union acpi_subtable_headers *header,
> +		     const unsigned long end)
> +{
> +	int rc;
> +	struct fwnode_handle *fn;
> +	struct acpi_madt_rintc *rintc;
> +
> +	rintc =3D (struct acpi_madt_rintc *)header;
> +
> +	/*
> +	 * The ACPI MADT will have one INTC for each CPU (or HART)
> +	 * so riscv_intc_acpi_init() function will be called once
> +	 * for each INTC. We only need to do INTC initialization
> +	 * for the INTC belonging to the boot CPU (or boot HART).
> +	 */
> +	if (riscv_hartid_to_cpuid(rintc->hart_id) !=3D =
smp_processor_id())
> +		return 0;

Why are we carrying forward this mess to ACPI? The DT bindings are
awful and a complete pain to deal with, as evidenced by how both Linux
and FreeBSD have to go out of their way to do special things to only
look at one of the many copies of the same thing.

Jess

> +
> +	fn =3D irq_domain_alloc_named_fwnode("RISCV-INTC");
> +	WARN_ON(fn =3D=3D NULL);
> +	if (!fn) {
> +		pr_err("unable to allocate INTC FW node\n");
> +		return -1;
> +	}
> +
> +	rc =3D riscv_intc_init_common(fn);
> +	if (rc) {
> +		pr_err("failed to initialize INTC\n");
> +		return rc;
> +	}
>=20
> 	return 0;
> }
>=20
> -IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
> +IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC,
> +		     NULL, 1, riscv_intc_acpi_init);
> +#endif
> --=20
> 2.38.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

