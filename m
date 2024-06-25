Return-Path: <linux-acpi+bounces-6605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB17917078
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 20:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2632628CB49
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017217D35A;
	Tue, 25 Jun 2024 18:44:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D7D17D353;
	Tue, 25 Jun 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341051; cv=none; b=mw9bNE1T8v5/dwvktoLJz7ashQQg1+xxHuDJc3IV/lfOKqNJTliRahbNijk/VKbWH3lbR0RPFda82bMw5K+Isb+Oy/E5m5CSHvw0wHP+aX1RUzh2Jp/KnRiIE1uXb/Z3VR2UORROqEPjmarXUUnpdk90Y9aL14tvWYuuqzn5FNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341051; c=relaxed/simple;
	bh=hohhvTJMwbP+pwz9eCrw5mTIHit6f9kP1oYy87iud3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXBD50Jk8MLbZbxjpiBEXVtNkWI3jnOH5mj8d61WLwQA2ckb/2WQLoJ/RMu1e+IvKHfx0WcimeoY4MLzNZxCYEYHf6bS+GRoqo1hvSIJyxRnsG7398r+nA5IGfgweTpWG3Qf/8j4c6+iyDA0iuoYaEUrlxD0yyuYk9VFK4SgkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1AF6339;
	Tue, 25 Jun 2024 11:44:33 -0700 (PDT)
Received: from [10.57.73.131] (unknown [10.57.73.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B5193F73B;
	Tue, 25 Jun 2024 11:44:06 -0700 (PDT)
Message-ID: <4db1945e-ec8c-4e96-90fc-cd5386a9d6b4@arm.com>
Date: Tue, 25 Jun 2024 19:44:04 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] OF: Simplify of_iommu_configure()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1718994350.git.robin.murphy@arm.com>
 <0dc14431c8a495e1135fc1d9c4500d4cb96b4e39.1718994350.git.robin.murphy@arm.com>
 <CAHp75VdnoOyKYbaNtr_UKn9NMSzXR1Syn9W7u0qtLgGuwYX6-Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAHp75VdnoOyKYbaNtr_UKn9NMSzXR1Syn9W7u0qtLgGuwYX6-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-22 11:23 pm, Andy Shevchenko wrote:
> On Fri, Jun 21, 2024 at 8:47 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> We no longer have a notion of partially-initialised fwspecs existing,
>> and we also no longer need to use an iommu_ops pointer to return status
>> to of_dma_configure(). Clean up the remains of those, which lends itself
>> to clarifying the logic around the dma_range_map allocation as well.
> 
> ...
> 
>> +       if (!err && dev->bus)
>> +               err = iommu_probe_device(dev);
>>
>> +       if (err && err != -EPROBE_DEFER)
>> +               dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> 
> Hmm... I'm wondering if dev_err_probe() can be used here.

It's still possible to have other errors here benignly [1] (however 
questionable the underlying reason), and this has always been a 
dev_dbg(), it's just getting shuffled around again. The aim here is to 
carry on removing cruft to work towards getting rid of this 
iommu_probe_device() call altogether since it's fundamentally wrong, so 
I'm not inclined to add anything new or spend too much effort polishing 
code I still want to delete.

>>          return err;
> 
> ...
> 
>> +       dev_dbg(dev, "device is%sbehind an iommu\n",
>> +               !ret ? " " : " not ");
> 
> Why not a positive test?

Again, mostly because that's how it was written in 2014, same reason I'm 
not deduplicating the redundant space despite it still being the tiniest 
bit irritating. If you make me think about it, though, I suppose when 
both outcomes are otherwise equally weighted it does seems natural to 
consider "success" before "failure", thus the condition tests for success.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh/

