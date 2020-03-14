Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7320D185770
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Mar 2020 02:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCOBia (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Mar 2020 21:38:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64875 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCOBia (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2020 21:38:30 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a1b766df2c349fa1; Sat, 14 Mar 2020 10:38:29 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alex Hung <alex.hung@canonical.com>
Cc:     corbet@lwn.net, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, mchehab+samsung@kernel.org, jpoimboe@redhat.com,
        akpm@linux-foundation.org, pawan.kumar.gupta@linux.intel.com,
        jgross@suse.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][RESEND] acpi/x86: add a kernel parameter to disable ACPI BGRT
Date:   Sat, 14 Mar 2020 10:38:28 +0100
Message-ID: <7409530.ikv4aRezOy@kreacher>
In-Reply-To: <20200304225529.6706-1-alex.hung@canonical.com>
References: <20200304225529.6706-1-alex.hung@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, March 4, 2020 11:55:29 PM CET Alex Hung wrote:
> BGRT is for displaying seamless OEM logo from booting to login screen;
> however, this mechanism does not always work well on all configurations
> and the OEM logo can be displayed multiple times. This looks worse than
> without BGRT enabled.
> 
> This patch adds a kernel parameter to disable BGRT in boot time. This is
> easier than re-compiling a kernel with CONFIG_ACPI_BGRT disabled.
> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
> 
>  * Resend to include linux-acpi emailing list
> 
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  arch/x86/kernel/acpi/boot.c                     | 10 +++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ffff776..55c5b2f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -442,6 +442,9 @@
>  	bert_disable	[ACPI]
>  			Disable BERT OS support on buggy BIOSes.
>  
> +	bgrt_disable	[ACPI][X86]
> +			Disable BGRT to avoid flickering OEM logo.
> +
>  	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
>  	bttv.radio=	Most important insmod options are available as
>  			kernel args too.
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 04205ce..d1757ce 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -45,6 +45,7 @@ EXPORT_SYMBOL(acpi_disabled);
>  #define PREFIX			"ACPI: "
>  
>  int acpi_noirq;				/* skip ACPI IRQ initialization */
> +int acpi_nobgrt;			/* skip ACPI BGRT */
>  int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>  
> @@ -1619,7 +1620,7 @@ int __init acpi_boot_init(void)
>  	acpi_process_madt();
>  
>  	acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);
> -	if (IS_ENABLED(CONFIG_ACPI_BGRT))
> +	if (IS_ENABLED(CONFIG_ACPI_BGRT) && !acpi_nobgrt)
>  		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>  
>  	if (!acpi_noirq)
> @@ -1671,6 +1672,13 @@ static int __init parse_acpi(char *arg)
>  }
>  early_param("acpi", parse_acpi);
>  
> +static int __init parse_acpi_bgrt(char *arg)
> +{
> +	acpi_nobgrt = true;
> +	return 0;
> +}
> +early_param("bgrt_disable", parse_acpi_bgrt);
> +
>  /* FIXME: Using pci= for an ACPI parameter is a travesty. */
>  static int __init parse_pci(char *arg)
>  {
> 

Applied as 5.7 material, thanks!




