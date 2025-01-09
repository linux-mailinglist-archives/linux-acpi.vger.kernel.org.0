Return-Path: <linux-acpi+bounces-10469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9781A07C9C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BC2167FA9
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21621E0B2;
	Thu,  9 Jan 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jme0nqef"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A82185B3
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jan 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438186; cv=none; b=YYyNr93y1oJ+VHmWtXgnGpk9E+psOILAabU16cQ8sFaP/AG+Ynr1ZuVzul1NzlezxisryYdE34btWttb/BOq64TXxleVywEIOTjDDdOoo/wB3lfrsvBmirjxF6Z9JFmAFMXFp38BVLjJnI1h7LHHXjrtHQvbbOi5ViJIhCZVttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438186; c=relaxed/simple;
	bh=SNq2LYQn8P2UJIoVa9/m6PlNC1XQn/zQ2r61dvzCKlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx7XNkj6AAfO0EmjfOtmiOV6huNlLucCYD1nz+6Wk0Y6yqat0RTQo1ihQY9bythzYPZT95AHVfA7OJNeuh/vk/IYzIh2+5gXM39AICS2RSZQDvjC2YzDkJZN8GlnuHSGqtXDB8JzONMQTRtpUNFkcIOs97a+GYyNwmXPwwMHVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jme0nqef; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd43b08674so10031176d6.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jan 2025 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736438183; x=1737042983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njGbwrLBenkbPUY93SRaaO4DmnW4npNEqO6tdBDTIK4=;
        b=jme0nqefzip8o0BUqR+QwB8AVuwgfyUxACkcVuaM/mF9Kz7+cZExgadeXOwvL8MM05
         u9oiaP+TxLsB52xEiG17AawFV0HEcxhaYQlcJH2lBZeKSr9UljSfdzStSx1bLLjAWS+g
         Qop4rPzLGsxmxP05SNYdawqvvMoV0UYRIe5w9FfdcCHLJC7+6pqOB2WcxY88P+o51+g8
         5ShvUvJTthbSHRFdz0JkedVOFa1WqCqCPtc57J2Za8+a9sa85jTXOh8yZPywpVcRpo4z
         d09+wwcCX0Gl/sJ/zLIyrPLMWjmpHSPyj1nKU4vqFZ9mzdWlc9t8hZDK7aUvzAUA4BqL
         kXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736438183; x=1737042983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njGbwrLBenkbPUY93SRaaO4DmnW4npNEqO6tdBDTIK4=;
        b=lUFbOBHhnKI0YtZj6ZS83fwr7Ih030eaVTCgIPQF+8Q71qKMIkB31F6H5goTsRsGZS
         Cy7L2tpnq7iQLYW496CpqRqXu/JQmdg6CJxetSDazwBIBTYUEzWk/BhlyF5sgoAzde3R
         afYGrntm7JCVT3Y8DncSdxkKDASKd0jpeiLEhx7Jo9ueP4lbHN1zSDIMCJXn7cr1/FKu
         7EKba+kNiXto3yitseNUg7V6iIJJQDtO2jyR0kQgz7xEfjoP6W1uP8DO4bdvaHuvBaPz
         HncJouXv4dojt+YXYioL3w07ImkkAJM6O8Ovh39/mpswbJLEb++sjI+Dd0fyy3pw8v4b
         fBjA==
X-Forwarded-Encrypted: i=1; AJvYcCVIhRtu+X0josatjCdUcLKd/SkqZt/6ZSSRi/9jE8svGYy5fh1BMttk1T7xV3QA9Wj3SgVO8tYP9fNK@vger.kernel.org
X-Gm-Message-State: AOJu0YySHSWPhkQCm0Io9rDTynKYURU67M9Q+5D7Ua47NwHqzQNSjRlc
	ANPEu+epOxVDlxQSDel0q3bg6bS7FdqVWnLEI2ze7nyRSqRtiOaXHwhsVBUnSco=
X-Gm-Gg: ASbGncsBSrGS+oYnGi+KNTo2y21ZEmnBQygbYHQUuy3VXxn7ke8ata6ivKmfXNNrki2
	UY3MX7DcU/Tt6CDHTzv83EWeNsb8jDQzlP6NVX7Q9V+mS14lZouB9cYzVQD1i7B6uNK1B3la0WH
	lsC9+mm2lLv1JocFmNWY07UX+3taShY40La7zfb+KYUPvU3ww1fJBdGqnyLy2TCsz4UGI1oWTrE
	SG6MnxDlTy71p+/4vZk+xMv3stOCv+GWIP95xKHGAvelpTRR2LR2PnXBQqhxr8TxSSUUlf07nr2
	tCUBENXDrWntaoA9s4vvYRLo+iwHLuVNdXo1Neo=
X-Google-Smtp-Source: AGHT+IFez9D+XlV+Dk3FYn6oJiRh6f1LxjuTL/0cjlz8YykT4uZIk0cd8uPDFKcv8Yq+uZvqm94bBg==
X-Received: by 2002:a05:6214:23c5:b0:6d8:890c:1f08 with SMTP id 6a1803df08f44-6df9b2348a7mr117716776d6.26.1736438183258;
        Thu, 09 Jan 2025 07:56:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bba3fsm202468036d6.71.2025.01.09.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:56:22 -0800 (PST)
Date: Thu, 9 Jan 2025 10:56:20 -0500
From: Gregory Price <gourry@gourry.net>
To: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, kernel_team@skhynix.com,
	42.hyeyoo@gmail.com, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?utf-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKQ==?= System SW <honggyu.kim@sk.com>,
	=?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] Re: [External Mail] [RFC PATCH] mm/mempolicy:
 Weighted interleave auto-tuning
Message-ID: <Z3_xpKZ7YtVvCSG4@gourry-fedora-PF4VCD3F>
References: <20241225093042.7710-1-joshua.hahnjy@gmail.com>
 <874j2rp6or.fsf@DESKTOP-5N7EMDA>
 <Z22cwZycFV47wOfX@gourry-fedora-PF4VCD3F>
 <87cyhdhon1.fsf@DESKTOP-5N7EMDA>
 <Z27JXDwEmplZCDEX@gourry-fedora-PF4VCD3F>
 <874j2lll91.fsf@DESKTOP-5N7EMDA>
 <769f98b3-f5e5-448c-966e-4dd5468e5041@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769f98b3-f5e5-448c-966e-4dd5468e5041@sk.com>

On Wed, Jan 08, 2025 at 10:19:19AM +0900, Hyeonggon Yoo wrote:
> Hi, hope you all had a nice year-end holiday :)
> 
... snip ...
> Please let me know if there's any point we discussed that I am missing.
> 
> Additionally I would like to mention that within an internal discussion
> my colleague Honggyu suggested introducing 'mode' parameter which can be
> either 'manual' or 'auto' instead of 'use_defaults' to be provide more
> intuitive interface.
> 
> With Honggyu's suggestion and the points we've discussed,
> I think the interface could be:
> 
> # At booting, the mode is 'auto' where the kernel can automatically
> # update any weights.
> 
> mode             auto         # User hasn't specified any weight yet.
> effective        [2, 1, -, -] # Using system defaults for node 0-1,
>                               # and node 2-3 not populated yet.
> 
> # When a new NUMA node is added (e.g. via hotplug) in the 'auto' mode,
> # all weights are re-calculated based on ACPI HMAT table, including the
> # weight of the new node.
> 
> mode             auto         # User hasn't specified weights yet.
> effective        [2, 1, 1, -] # Using system defaults for node 0-2,
>                               # and node 3 not populated yet.
> 
> # When user set at least one weight value, change the mode to 'manual'
> # where the kernel does not update any weights automatically without
> # user's consent.
> 
> mode             manual       # User changed the weight of node 0 to 4,
>                               # changing the mode to manual config mode.
> effective        [4, 1, 1, -]
> 
> 
> # When a new NUMA node is added (e.g. via hotplug) in the manual mode,
> # the new node's weight is zero because it's in manual mode and user
> # did not specify the weight for the new node yet.
> 
> mode             manual
> effective        [4, 1, 1, 0]
> 

0's cannot show up in the effective list - the allocators can never
percieve a 0 as there are (race) conditions where that may cause a div0.

The actual content of the list may be 0, but the allocator will see '1'.

IIRC this was due to lock/sleep limitations in the allocator paths and
accessing this RCU protected memory. If someone wants to take another
look at the allocator paths and characterize the risk more explicitly,
this would be helpful.

> # When user changes the mode to 'auto', all weights are changed to
> # system defaults based on the ACPI HMAT table.
> 
> mode             auto
> effective        [2, 1, 1, 1]  # system defaults
> 
> In the example I did not distinguish 'default weights' and 'user
> weights' because it's not important where the weight values came from --
> but it's important to know 1) what's the effective weights now and 2) if
> the kernel can update them.
> 
> Any thoughts?
> 
> ---
> Best,
> Hyeonggon

