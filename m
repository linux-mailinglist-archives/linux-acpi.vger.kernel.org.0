Return-Path: <linux-acpi+bounces-1013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBC47D82B3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF1A2804E3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D2F2DF91
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/kI//wp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB042156D9
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 10:47:38 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5618D
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 03:47:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so10048701fa.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698317253; x=1698922053; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zARtYhe8iofTNi9oUIWhel0XKe8pA8fsGQ6TZX749AM=;
        b=h/kI//wpeIXTKh9Yxbd7z7B3SptYh7FLI7bpeO2DBb+ZRX50IXHgU1nuo7PyozAFma
         NeRc5NWVI6rJBzLdH3zERIxeaJ0m8jZzX5uILNDaENwXx3DyBL+9ZDzhcPQUO2CVU/JM
         l2gPXcYizmz7qS7y/kgmVqV/E4tj73kvsieo30eOHvWkKG4h11w1zQgztfEQWH61qmHi
         eD3/mAulkztQx1ZsgrZKmjqCERq1X1ZCeMVf5KHuEI4EFDy+Pu00qSLAsmbmXPHi89sz
         q9nSIDSSX2hfIVOAVYQbVynoRjvpqhcGj1iw4SYZddGBy0XcsDOIFYSUeG7oIBboVjOY
         DPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698317253; x=1698922053;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zARtYhe8iofTNi9oUIWhel0XKe8pA8fsGQ6TZX749AM=;
        b=X45gbu5qK/psKSFltGSX3slV9w9/bpo3anv/3PkKm0S3RIT7FnJ4UgNI661cvDHtpZ
         10qOcYAjyjEX2GC66ZM2OOAiJBiH+dNyAUJp/2yl4PWslarmd2GCQf54aJglOTJDcJWz
         Hqvji17/aqJszENQladDDW0x5o2kf8pZKuCWOHqCZPEzxqC8CaRW6iw4eOqss3XCvJen
         N3epMxp0FrA4D6uaG6Fg6skPFHyt8NvtsUlXjuGqhkKxtotV29g2GQvaizqqOlxtEhXW
         3pOd78WGKA3wmdN0Z13VuOf0R8Jo2jxc6LUdoUju4gtXx+rFG4Y78MewVzfozVP9tGy9
         XnIQ==
X-Gm-Message-State: AOJu0YxQADlU3Y9JNpN+MjbYjFUlCQ3yPQy/HvJaLACdNX0qluQVfVcd
	8yHTqeiRXau5fz26n2wgzPZSoQ==
X-Google-Smtp-Source: AGHT+IGmxzfDQpaW9n6+VyxCuLkhAmG3EoFq/lPNhAkHV71yn+1V0RyR8hD7hkbdqONXHHeDunN5Vg==
X-Received: by 2002:a05:651c:1038:b0:2c5:1bd9:f95c with SMTP id w24-20020a05651c103800b002c51bd9f95cmr11798854ljm.53.1698317253615;
        Thu, 26 Oct 2023 03:47:33 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id t13-20020a2e8e6d000000b002c4faf47378sm2822174ljk.28.2023.10.26.03.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:47:33 -0700 (PDT)
Date: Thu, 26 Oct 2023 12:47:31 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: D Scott Phillips <scott@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Darren Hart <darren@os.amperecomputing.com>,
	patches@amperecomputing.com, sfr@canb.auug.org.au,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
Message-ID: <20231026104731.GA1296512@mutt>
References: <86ttqe4n1h.fsf@scott-ph-mail.amperecomputing.com>
 <20231025180627.GA1756475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025180627.GA1756475@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)

On 2023-10-25 13:06, Bjorn Helgaas wrote:
> On Wed, Oct 25, 2023 at 10:41:46AM -0700, D Scott Phillips wrote:
> > Bjorn Helgaas <helgaas@kernel.org> writes:
> > 
> > > On Fri, Sep 29, 2023 at 05:20:36PM -0700, D Scott Phillips wrote:
> > >> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> > >> also present to request system firmware control of attention LEDs. Add an
> > >> ACPI PCI Hotplug companion driver to support attention LED control.
> > >> ...
> > >
> > >> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> > >> +		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,
> > >
> > > pci_domain_nr() returns "int" (normally 32 bits), but since this is an
> > > ACPI system, the domain comes from _SEG, which is defined to be 16
> > > bits (ACPI r6.5, sec 6.5.6).
> > >
> > > So it looks like ORing in the "slot << 4" clobbers the upper 12 bits
> > > of _SEG.
> > >
> > > Is this code doing the right thing?
> > 
> > Hi Bjorn,
> > 
> > on these Altra platforms _SEG is limited within 0-11. I can add an `&
> > 0xf` to pci_domain_nr() to make it clear that the segment number is
> > encoded down into 4 bits in the smc request.
> 
> If the following looks OK, we're all set.  I put these on pci/hotplug
> for v6.7, thanks!
> 
> +static int set_attention_status(struct hotplug_slot *slot, u8 status)
> +{
> +	struct arm_smccc_res res;
> +	struct pci_bus *bus;
> +	struct pci_dev *root_port;
> +	unsigned long flags;
> +	u32 handle;
> +	int ret = 0;
> +
> +	bus = slot->pci_slot->bus;
> +	root_port = pcie_find_root_port(bus->self);
> +	if (!root_port)
> +		return -ENODEV;
> +
> +	local_irq_save(flags);
> +	arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
> +		      led_service_id[2], led_service_id[3], 0, 0, 0, &res);
> +	if (res.a0) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +	handle = res.a1 & 0xffff0000;
> +
> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> +		     PCI_SLOT(root_port->devfn) << 4 | pci_domain_nr(bus) & 0xf,
> +		     0, 0, handle, &res);
> +	if (res.a0)
> +		ret = -ENODEV;
> +
> +	arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
> +
> + out:
> +	local_irq_restore(flags);
> +	return ret;
> +}

Hi,

Building todays linux-next tag next-20231026 for arm64 with
CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA=m I see the following build error.

drivers/pci/hotplug/acpiphp_ampere_altra.c: In function 'set_attention_status':
drivers/pci/hotplug/acpiphp_ampere_altra.c:63:75: error: suggest parentheses around arithmetic in operand of '|' [-Werror=parentheses]
   63 |                      PCI_SLOT(root_port->devfn) << 4 | pci_domain_nr(bus) & 0xf,
      |                                                        ~~~~~~~~~~~~~~~~~~~^~~~~
include/linux/arm-smccc.h:382:44: note: in definition of macro 'arm_smccc_smc'
  382 | #define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)
      |                                            ^~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:243: drivers/pci/hotplug/acpiphp_ampere_altra.o] Error 1

Looks like this is the problematic patch
13ba8a09c4f6 ("PCI: hotplug: Add Ampere Altra Attention Indicator extension driver")

Cheers,
Anders

