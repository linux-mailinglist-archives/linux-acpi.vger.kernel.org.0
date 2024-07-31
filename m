Return-Path: <linux-acpi+bounces-7161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6E9427C6
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 09:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE76F1F2207C
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E781A720A;
	Wed, 31 Jul 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpZzX1nO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4C1A71EA;
	Wed, 31 Jul 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410654; cv=none; b=aTnaEtiMomtox6othGHtTKHkU5MBxIlQe+skadE0cpe8bRqD4E9uDXEUg6MR/40B+CkaF/EsIC+aV6Cn1RvHOxGqmGP8cIU6CkbJtavIfqSiI7nVJqLEFe7Od8EhTsYf6+SVIz7Oj8ebYmQXnmhOMWDJnoQzVWFZEcK/PLjl2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410654; c=relaxed/simple;
	bh=+RxA06oYCh2UbrzIR0pUSBtDnMy+8VwtTACTDRrlDd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=stsd5IHZZPtL6qfWAf7Hpmx6JecRrFINg3uVXqHf3zqoKV31Mpx8fHcWNyrLTn+6kKR6fz68NojUYtU+j5gD7J5vGCkKvT+s+/0oSOmq+Bt3DMjreUoiyVfUmD3H3pDSW9UHFVX42kXyjmprc3qGgVxip50TzrGccrmKKHoi6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpZzX1nO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722410653; x=1753946653;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+RxA06oYCh2UbrzIR0pUSBtDnMy+8VwtTACTDRrlDd4=;
  b=SpZzX1nOKrATvWJCoeOnPRGefNJSfdMY47EiJJaDMgnUqe3mJPHLUZrC
   yZz5rOwpij9dWGsmrI0H12pMJpUDZG774XNGLbTkidxhp+kOhPF/TRT3G
   MP190del3TzYVmGXDN275PfLoP0B2dISss7KgJgfHIl9W91g1DkxlX4mC
   spaWm3bImbnF8ZcmLjwS3RiVqCrK6mlxCdIk/Vn4hJBdGixSBSoFQnU9b
   7lhEpiONdAsQTDA8THHGPfvETag3Lv1ZH0uFUCKyv/q3FUPMrQawBAlhc
   3P6Ra/Q4XsHBMA5RKsR5cjD6elRuR1bjJuymsPojjGCsmDgp2wTv4A13b
   Q==;
X-CSE-ConnectionGUID: RpBPpdTcTDaZBjrbZqI6TA==
X-CSE-MsgGUID: +bU8Iy9pQxGWWpr0p1NyNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="37784021"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="37784021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 00:24:12 -0700
X-CSE-ConnectionGUID: CV578NcQS3GWlq23JdJ6+Q==
X-CSE-MsgGUID: 8jrySnJVSk2QjPs9EjQBHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54594416"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 00:24:10 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  dave.jiang@intel.com,
  Jonathan.Cameron@huawei.com,  horenchuang@bytedance.com,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  dan.j.williams@intel.com,  lenb@kernel.org,  "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
In-Reply-To: <ZqlF0hn6Jh4Ybl-p@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Tue, 30 Jul 2024 15:58:10 -0400")
References: <20240726215548.10653-1-gourry@gourry.net>
	<87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
	<877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZqhbePA9Egcxyx7o@PC2K9PVX.TheFacebook.com>
	<87cymupd7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZqlF0hn6Jh4Ybl-p@PC2K9PVX.TheFacebook.com>
Date: Wed, 31 Jul 2024 15:20:37 +0800
Message-ID: <878qxiowmy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Wed, Jul 31, 2024 at 09:22:32AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > This presumes driver configured devices, which is not always the case.
>> >
>> > kmem.c will set MEMTIER_DEFAULT_DAX_ADISTANCE
>> >
>> > but if BIOS/EFI has set up the node instead, you get the default of
>> > MEMTIER_ADISTANCE_DRAM if HMAT is not present or otherwise not sane.
>> 
>> "efi_fake_mem=" kernel parameter can be used to add "EFI_MEMORY_SP" flag
>> to the memory range, so that kmem.c can manage it.
>> 
>
> In this case, the system is configured explicitly so that kmem does not
> manage it. In fact, some systems still cannot be managed with
> EFI_MEMORY_SP due to hpa!=spa issues that the driver cannot manage.

Sorry, I don't understand.  IIUC, kmem.c can manage almost any memory
range via drivers/dax/hmem.  Please check

drivers/dax/hmem/device.c
drivers/dax/hmem/hmem.c

Could you elaborate why kmem.c doesn't work for some memory range?

>> > Not everyone is going to have the ability to get a platform vendor to
>> > fix a BIOS bug, and I've seen this in production.
>> 
>> So, some vendor build a machine with broken/missing HMAT/CDAT and wants
>> users to use CXL memory devices in it?  Have the vendor tested whether
>> CXL memory devices work?
>>
>
> As I mentioned, the broken aspect is being fixed, however there are
> existing production hardware which do not have HMAT entries.
>
>> > But the first step here would be creating two modes.  HMAT-is-sane and
>> > CPU/Non-CPU seems reasonable to me but open to opinions.
>> 
>> IMHO, we should reduce user configurable knobs unless we can prove it
>> is really necessary.
>>
>
> That's fair and valid.
>
> But I think a feature that worked in 5.x should work in 6.x, and right
> now the change in node placement breaks hardware that worked with 5.x
> which happened to have broken or missing HMAT.

--
Best Regards,
Huang, Ying

