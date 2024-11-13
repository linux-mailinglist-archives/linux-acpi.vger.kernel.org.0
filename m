Return-Path: <linux-acpi+bounces-9531-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05329C6941
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 07:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806952877E1
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 06:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37C21714BC;
	Wed, 13 Nov 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQtqY1j5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C91779B8
	for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479351; cv=none; b=pCCo2eN67WJ3hiFfROreCNnAmsB0TMAiMpao0bmhlEjPV6uYw9R8W7NfDrcW9ivCfxfs3t+4nA06ULMsvPY4mAZ8lqvkZJn4kgBNb7naVEB7XHcVXu2Q/e0cvzagu4zGjGk9KhEQwFwVqPCw0r4z0P+dXO7SK65pZaScnfTAS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479351; c=relaxed/simple;
	bh=ryKZ3ZF7sN+kjlkdznbBZ1GozgBjmJSrP4P2jIodaXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDkefEfaSpnWcald83f+Au+uf3FGEQBbcKnNo/PgQ2IOydVMmzcB7uBXd0G4M45IjfFYvxFGevu1N0PODGTzuAJL0xbldwF0bMpDlmMrvJjlIUSS2eSuIUET1rX8fLAOgZ0CyyAz5iQ4BvBn2ObMKcD5eYJTRPe5aJuD5sxg1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WQtqY1j5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so575493e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 22:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731479348; x=1732084148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9QCU/JLa948seWzRrNmkByaOgxKmnVBehQKimS55YRs=;
        b=WQtqY1j5mGUp6K+OS8i21t023WgFcGnaPntb4Obk23sKqdmFCVqIEJ0Cm7yaZEanMV
         gUOXp/4VV96oUyHB/rN22VI82czJAUNuFWPMUqL5GS8bFruFqO/+nlf6vgQ/iqU7JkJ+
         xxdA5cpHOwmFJqb1xeCCJ8mJB3a9aPBwUcBYgitplO7IKEl1vDaALu81C5g+DbnWnZkP
         BWC8+t0bp0bbM7VXEpAyIdNG6tf/H96kzWUcBeaR+WiDNNsZU1CMYCJWOBa0fhim/5NC
         FcuPfwzGgBuEwuFEroqNB4vVJSQ7hkiwE/JQiV8S2ZxVWV/5WU89zm4f5j0Ql3NyA6KU
         yjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479348; x=1732084148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QCU/JLa948seWzRrNmkByaOgxKmnVBehQKimS55YRs=;
        b=Q+2HYqJyHc91m5U0FMncWnwlSVuSacOExn8scIc2KYX+pNTtj/3Iqpbm7Rnz0ScpbS
         BqjOK5db5wVodwfF/CZcOHJlu/cxRzjD4gDUSicsHUVG2DqIQ3DWZydfBqumYygL9NLW
         KZaQOg7bavISqWMUxgiPPan7fnjyorfnXC9eqJr3Y9RUEHHSzLOe1RQiraFhRidDVVAO
         aS6VGb86nfnRIqfvTk1XBYad2q+F95g8jFk23ULdk4R/CBxYtddwtVTog8RMCHWjlEvI
         z0qCrroDh8Uv0R/pVOKTd1sUALa6/s9DraQmjBDzdxVlAUawyALXPSQ/tIwJkJO+ZpmE
         NezA==
X-Forwarded-Encrypted: i=1; AJvYcCVcqLsqr56/eDsEZzCTnDx1xLCq4C2lk2e2y9B29ULI8v3PNT6EWSRMQeNi1NHK3CbiGA8e/V8W6mL7@vger.kernel.org
X-Gm-Message-State: AOJu0YxOcNfkE9Wj1SlaTGEYIeh10jR9pkGxJtSu44p7Hsvn9YyLlBVF
	XgkeVTrSg2Ly3BYA0oL8s5GRoM0wE5hL3PTndeWH2Ng2FkhQ1PBxWPnP79TpaWeMTUQJE5pskc1
	//SySD9AhS/JayUKFBgF7qGDu7gMjqNAU8M7n3Q==
X-Google-Smtp-Source: AGHT+IEEpcf7Vups7lw1NP9O1FTEPXG1XjljcLFymoWHBWMOkn9tB109/qtbls5Dq+XYyRVJ67vPr0ofrW4PZLq41wk=
X-Received: by 2002:a05:6512:281b:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-53d86303095mr9309340e87.54.1731479348058; Tue, 12 Nov 2024
 22:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com>
 <20241112182938.GA172989@nvidia.com> <CABQgh9HOHzeRF7JfrXrRAcGB53o29HkW9rnVTf4JefeVWDvzyQ@mail.gmail.com>
 <20241113012359.GB35230@nvidia.com> <9df3dd17-375a-4327-b2a8-e9f7690d81b1@linux.intel.com>
In-Reply-To: <9df3dd17-375a-4327-b2a8-e9f7690d81b1@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 13 Nov 2024 14:28:56 +0800
Message-ID: <CABQgh9F+K67YDYeg4==0dhdjya1YuX6uUttQA8zadWEZyRhNKw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Initial support for SMMUv3 nested translation
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, acpica-devel@lists.linux.dev, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Wed, 13 Nov 2024 at 10:56, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 11/13/24 09:23, Jason Gunthorpe wrote:
> >> https://github.com/Linaro/linux-kernel-uadk/tree/6.12-wip
> >> https://github.com/Linaro/qemu/tree/6.12-wip
> >>
> >> Still need this hack
> >> https://github.com/Linaro/linux-kernel-uadk/commit/
> >> eaa194d954112cad4da7852e29343e546baf8683
> >>
> >> One is adding iommu_dev_enable/disable_feature IOMMU_DEV_FEAT_SVA,
> >> which you have patchset before.
> > Yes, I have a more complete version of that here someplace. Need some
> > help on vt-d but hope to get that done next cycle.
>
> Can you please elaborate this a bit more? Are you talking about below
> change
>
> +       ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA);
> +       if (ret)
> +               return ret;
>
> in iommufd_fault_iopf_enable()?
>
> I have no idea about why SVA is affected when enabling iopf.

In drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c,
iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA) will real call
iopf_queue_add_device,
while iommu_dev_enable_feature(IOPF)  only set flag.

arm_smmu_dev_enable_feature
case IOMMU_DEV_FEAT_SVA:
arm_smmu_master_enable_sva(master)
iopf_queue_add_device(master->smmu->evtq.iopf, dev);

Thanks

