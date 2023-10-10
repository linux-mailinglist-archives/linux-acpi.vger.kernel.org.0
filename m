Return-Path: <linux-acpi+bounces-567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B707BFF68
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8595A1C20BC7
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDE1428E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2mV4bgm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863124C60
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 14:10:49 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720FA9
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 07:10:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4054f790190so55724195e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696947046; x=1697551846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9e9qPLTB7aTb33k8UbCxTMNueWeOwcIlIcYVdpYZ3cI=;
        b=K2mV4bgmYrkb4DoKGCtdrcwfgvvuoBIuPpP/yzkJjaJLvvUnK4C7EASaOOVphQbXd3
         +jMDlRkhLhKHXHo3OcRzdwQouf5/M3nNrLa4Cj1JEvJ+1PazSLqpfumkH1KqQWCt4LLH
         FMpkdSQtMJHKLmAz4EQByE+0OEW4wQCUoHGiuMSgKuhBgUiqRwnbCjhCk5tUarfccSzu
         v3Wawpas2z3AcK1Rezfw1hbYAQ1G0v8Nqz56r33qnahq0KQIrMBk1B/+wVLH+k62lv6B
         p5tLuvcY0tDmR15AcdxrxJzEenkIBXKloapkGnkc6hWL6BRCzWHFbCymTOamEKxVpJjB
         SBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947046; x=1697551846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9e9qPLTB7aTb33k8UbCxTMNueWeOwcIlIcYVdpYZ3cI=;
        b=B8LHalDrDjwCxoBqp3ku8ZWlKy1n4LW8l3NXy6QhEipVStBzuQIzNp0Kg4h9FXA3OS
         Sb3cgIDj4grRDe/SGXZ87zeRfcmh4u4khUlNPzpIDt6G+ThZxJPF6A6PsykmAQcbD7sq
         96HXoHSkbbm44/QCaFztbccLplNtnSkRtszQlLtWzQakVDCJixwAVeaYOijmEU/uBWBF
         FVDBDE9t62V5Nc/8nVbKIhgsu4k7bajhnHTDnfowbeLU9L54zmjm346TtWqUVTA9vT1L
         DcrZjBZ9RN1AH8J0XodeeMDZl0y8fBd3yD7/2GafLtgJYsUcwheZJq8Osf66kDAYGork
         xqww==
X-Gm-Message-State: AOJu0Yxvm7sdwtJQmWatgBEvVETYDRUBkeOfqI1ipHsOsSazhyCBt1bo
	VENImaj2YF5Bms5vdd1lgTROKQ==
X-Google-Smtp-Source: AGHT+IF64TnPs4jd+aNGnYlkrrYVkn+PA9w557txyTj+b9RkiQXDiaHv59LSHcuO7lnyVAUeR6HMwA==
X-Received: by 2002:a05:600c:1c10:b0:407:5adc:4497 with SMTP id j16-20020a05600c1c1000b004075adc4497mr785100wms.9.1696947046314;
        Tue, 10 Oct 2023 07:10:46 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id p20-20020a1c7414000000b0040651505684sm14275256wmc.29.2023.10.10.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:10:45 -0700 (PDT)
Date: Tue, 10 Oct 2023 15:10:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	D Scott Phillips <scott@os.amperecomputing.com>
Subject: Re: [PATCH] ACPI: bus: Move acpi_arm_init() to the place of after
 acpi_ghes_init()
Message-ID: <20231010141052.GB2902909@myrica>
References: <20231010082123.4167603-1-guohanjun@huawei.com>
 <20231010085012.qkntexfsph333sif@bogus>
 <717a0880-1bc4-461f-bd42-c522d653b3ea@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717a0880-1bc4-461f-bd42-c522d653b3ea@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:30:56AM +0100, Robin Murphy wrote:
> On 2023-10-10 09:50, Sudeep Holla wrote:
> > On Tue, Oct 10, 2023 at 04:21:23PM +0800, Hanjun Guo wrote:
> > > acpi_agdi_init() in acpi_arm_init() will register a SDEI event, so
> > > it needs the SDEI subsystem to be initialized (which is done in
> > > acpi_ghes_init()) before the AGDI driver probing.
> > > 
> > > In commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
> > > initialisation into acpi_arm_init()"), the acpi_agdi_init() was
> > > called before acpi_ghes_init() and it causes following failure:
> > > 
> > > | [    0.515864] sdei: Failed to create event 1073741825: -5
> > > | [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
> > > | [    0.515867] agdi: probe of agdi.0 failed with error -5
> > > | ...
> > > | [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.
> > > 
> > > Fix it by moving acpi_arm_init() to the place of after
> > > acpi_ghes_init().
> > > 
> > > Fixes: fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()")
> > > Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
> > > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > > ---
> > > 
> > > I did a test on a ARM server and I didn't see regressions, but
> > > I don't have a AGDI table firmware, so Scott please give a
> > > test to see if it fixes your issue.
> > > 
> > >   drivers/acpi/bus.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index f41dda2d3493..a4aa53b7e2bb 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -1410,10 +1410,10 @@ static int __init acpi_init(void)
> > >   	acpi_init_ffh();
> > > 
> > >   	pci_mmcfg_late_init();
> > > -	acpi_arm_init();
> > >   	acpi_viot_early_init();
> > >   	acpi_hest_init();
> > >   	acpi_ghes_init();
> > > +	acpi_arm_init();
> > 
> > I am fine with the change, but just wanted to check with Robin/Jean-Philippe
> > if there are any dependency on IORT initialisation for VIOT ? IIUC IORT was
> > always initialised before VIOT but that changes after this change.
> 
> They should be independent, and typically we'd only expect to see one or the
> other anyway (although strictly a VMM *could* provide virtio-iommu for some
> devices while also emulating an SMMU for others if it really really wanted
> to).

IORT also describes the GIC ITS topology, so QEMU (and likely
cloud-hypervisor) do present both tables to a guest. But I don't think the
order matters in any case, and QEMU still boots fine with this patch.

Thanks,
Jean


