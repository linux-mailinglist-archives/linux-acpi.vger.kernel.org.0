Return-Path: <linux-acpi+bounces-1104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D87DC475
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 03:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2273B20A3B
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D65251
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RA0zuQur"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E151A54
	for <linux-acpi@vger.kernel.org>; Tue, 31 Oct 2023 02:00:49 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98E5E8
	for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2023 19:00:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4109865a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2023 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698717647; x=1699322447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysFHtwfLEtis2HEwrxQHDKnfNsPImE2g/7GGtzNp+Cs=;
        b=RA0zuQurBpzYYfjoncjl1kshFj3iAGNIw3NKTxySaBBPtVj/wd5SKoIIAEqT071n2g
         u8J8MlnD8DYzzR4sOIQPxbwdVqRqjyN1CPa2FTv+5p0A6cWkQqe9e5/wx7ZoTZre/dws
         n6YeCGYiyXr0yQYwjly+z4aEl4jxOH/7s1dtkQ7y7hoyy7/7jUM0j5ddNVd+B/zJadk+
         sb1a++EwzSH11of0XYBZmkazOmcCqjL4Exyyk7ZJHvpsCehjyowvTW8DWITyYOvg6fUw
         sr5RJmpYKdB0yuSm6ixVX0ixxlNR3G2v9EyVqHnquwekNJ0sboVSZB30lCkWvcA1EI//
         Nziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717647; x=1699322447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysFHtwfLEtis2HEwrxQHDKnfNsPImE2g/7GGtzNp+Cs=;
        b=JXav6sMZpP8rteUMuDcEKJY0vqYN2lYJx73AqNeQNdsP3K0h4spKLS24CJRPpsAVGS
         Qt5PHKmfmfQD+f7gl26Q1McGYLiuvM3sc/WZ/PJAu//ZB5DkzJv2hc6UYanf8jIANz+e
         oqj1YWFwYNqYRKfE/subUcLm+HlUKoW2NwDMqGma8TPiC6woRcefjGe423ax5LC/qt15
         hodgMlpfquYY8tpHoaxtuyrK0Ps2L3xHDNv9aO9s1X7ik4dugbd0cW7sBqVGAzL3Xoo7
         XRWy5PM1H6S1t6j8IuvIlAujU3Vprnlu9mUmjCCnT0YOW99DOJDb0qJeO9VJp1pGMAAw
         r5Qw==
X-Gm-Message-State: AOJu0YzP9uLiLgE/kuKyYimHd94qtMgaJnYzK2UKpYc9eglsWJvXW5wI
	bbGMMVAX2Zb6OUUpFAl2D4REbA==
X-Google-Smtp-Source: AGHT+IEf0KaLXQATJy7Y+aQfRDpTBjnOxd6k1XM+fNDmCwu9+0PAZyGarOs4HgtrLS/PIbK2VfXdgQ==
X-Received: by 2002:a05:6a20:a220:b0:17b:e0a3:f6f4 with SMTP id u32-20020a056a20a22000b0017be0a3f6f4mr9170362pzk.25.1698717647083;
        Mon, 30 Oct 2023 19:00:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b006934e7ceb79sm159585pfl.32.2023.10.30.19.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:00:46 -0700 (PDT)
Date: Tue, 31 Oct 2023 07:30:35 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 11/21] PCI: MSI: Add helper function to set system
 wide MSI support
Message-ID: <ZUBfw2vrzc+GyAny@sunil-laptop>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-12-sunilvl@ventanamicro.com>
 <87a5s0yyje.ffs@tglx>
 <ZT/t0UY5rbudhjfH@sunil-laptop>
 <874ji7zz7a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ji7zz7a.ffs@tglx>

On Mon, Oct 30, 2023 at 08:29:13PM +0100, Thomas Gleixner wrote:
> On Mon, Oct 30 2023 at 23:24, Sunil V. L. wrote:
> > On Mon, Oct 30, 2023 at 03:28:53PM +0100, Thomas Gleixner wrote:
> > Just noting related discussion :
> > https://www.spinics.net/lists/linux-serial/msg57616.html
> >
> > The MSI controller on RISC-V (IMSIC) is optional for the platform. So,
> > when by default pci_msi_enable = 1 and the MSI controller is not
> > discovered, we get stack trace like below.
> 
> <SNIP>
> 
> > So, what I did was, by default call pci_no_msi() to disable MSI and then
> > call pci_set_msi() to enable when MSI controller is probed.
> 
> Your taste sensors should have gone out of range ...
> 
> > But I think Bjorn's suggestion to depend on PCI_BUS_FLAGS_NO_MSI may be
> > better idea. In that case, we need to set bridge->msi_domain to true in
> > pci_create_root_bus(). Let me know what do you prefer or if I am
> > completely missing something here.
> 
> That's definitely more sensible, but as I said in the other thread, Marc
> is the one who did the PCI core/bridge setup magic and he is definitely
> in a better position to answer that bridge->msi_domain question.
> 
Thanks!. It looks like Marc introduced bridge->msi_domain in [1] for
exactly the same problem we have with RISC-V + ACPI. Let me remove this
hack and do similar to pci_host_common_probe() in next revision unless I
get objections to that approach.

Sorry, somehow my script didn't copy Marc in the series. Will make sure
I copy him explicitly in next revision.

[1] - https://lore.kernel.org/all/20210330151145.997953-12-maz@kernel.org/

Thanks!
Sunil

