Return-Path: <linux-acpi+bounces-11766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92431A4DE99
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00AB1767E1
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E72010E3;
	Tue,  4 Mar 2025 13:03:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F9442C;
	Tue,  4 Mar 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093411; cv=none; b=D8Qrh1vyj/P6ao/lpV7OETlcACm3Jb8NsighsaV/1/hFFIdhrJIU+TnoxpzdVig2779A64EPxLNeHT8nYkXUa6GzH9RNIkYvTTkg0YS6qSFtIUAOsIIVY+9mNvkyb2C7nRjVVM9GF9eQM0fyrFH+mtWrpiWZ5xuWNER5wZRTsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093411; c=relaxed/simple;
	bh=jGFfWBKXukbqHaXl3amXekS7y7SRP7mA+YmsLXI+alM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mOqxx0ocuDIBd+C+1kUJ3h8lTynbwtS9WDMg5ecT3362vLtG6o3xlvl7s0g9ZEFy5jfUg0+BQ9bZ3kYmsLb7833TkqYJ+3eb0XCoHB2VOhG/2siUXuXPLT3IZCFeDqMoqUm3LxETZc2RMC+tD4oGnMrpD1sfQRNqGAYv5URguo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-c9-67c6fa1bc9a6
Message-ID: <95541985-8d40-4ded-a83e-46203c441640@sk.com>
Date: Tue, 4 Mar 2025 22:03:22 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
 harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
 gregkh@linuxfoundation.org, rakie.kim@sk.com, akpm@linux-foundation.org,
 rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Content-Language: ko
To: Gregory Price <gourry@gourry.net>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8XWqQdPC7245FA2@gourry-fedora-PF4VCD3F>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <Z8XWqQdPC7245FA2@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsXC9ZZnka70r2PpBvP+81jMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPOh2/ZLJbv
	62e0uLxrDpvFvTX/WS3mfpnKbLF6TYaDoMfhN++ZPXbOusvu0d12md2j5chbVo/Fe14yeWxa
	1cnmsenTJHaPEzN+s3jsfGjpsbBhKrPH/rlr2D3OXazw+Pj0FovH501yAXxRXDYpqTmZZalF
	+nYJXBk7V31gLtjMXzH74EWmBsZOni5GDg4JAROJFS1MXYycEOa+fywgYV4BS4mzl4NAwiwC
	KhKL7raygNi8AoISJ2c+AbNFBeQl7t+awd7FyMXBLPCYWeLTnS5mkISwQJTEzld/wWYyC4hI
	zO5sYwaZKSKgKtF2xR2kXkjgLKPE23f7GUFq2ATUJK68nARWzylgJjF93112iF4zia6tXYwQ
	trzE9rdzmEGaJQTusUtM33OUDeJoSYmDK26wTGAUnIXkwFlIds9CMmsWklkLGFlWMQpl5pXl
	JmbmmOhlVOZlVugl5+duYgTG8LLaP9E7GD9dCD7EKMDBqMTDG/DzWLoQa2JZcWXuIUYJDmYl
	EV7Tz0Ah3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjJMZ
	P27X9TPoK6+X/Pf/+uJX/S09Wz9pZugKaWd594W1TGy996ik6OcDxi55K5knM/M496neKFty
	MlSaXd1+mczuiTK6h5f1s1dxLv9w48nTcpc1qbdfXo7jmftuV+Y9X5m94SrKqg+UJbmvv6hs
	2jplZ77Z4Uy9N81Ktg85+LTm1dlejSqSVmIpzkg01GIuKk4EADZxK+HdAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsXCNUNLT1f617F0g5NrmC3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4W95c9Y7G43X+O1WLVwmtsFse3zmO32HcRqOHw3JOsFjsf
	vmWzWL6vn9Hi8q45bBb31vxntZj7ZSqzxaFrz1ktVq/JsPi9bQWbg4jH4TfvmT12zrrL7tHd
	dpndo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN47Hxo6bGwYSqzx/65a9g9zl2s8Pj49BaL
	x7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoErY+eqD8wFm/krZh+8yNTA2MnTxcjJISFg
	IrFi3z+WLkYODl4BS4mzl4NAwiwCKhKL7raygNi8AoISJ2c+AbNFBeQl7t+awd7FyMXBLPCY
	WeLTnS5mkISwQJTEzld/mUBsZgERidmdbcwgM0UEVCXarriD1AsJnGWUePtuPyNIDZuAmsSV
	l5PA6jkFzCSm77vLDtFrJtG1tYsRwpaX2P52DvMERr5ZSO6YhWTFLCQts5C0LGBkWcUokplX
	lpuYmWOqV5ydUZmXWaGXnJ+7iREYr8tq/0zcwfjlsvshRgEORiUe3oCfx9KFWBPLiitzDzFK
	cDArifCafgYK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1
	MHod1NCetdD1nQDDxL85Grl7EgxOVm7wfN2lz7Xy9I513jbbpidXzxW7lnl+4dPNJSctTp8O
	augW9zK3maCc9Zc/3jrm571zW/U2/Tfe2dGbJrYsfl9AyaVLe+vC7ZXtDm6z1lwwa4rehSsr
	+Ms7izefy9gsNvW9c8hDq1PnrfMXpmwx77i4+K8SS3FGoqEWc1FxIgD06bnY0wIAAA==
X-CFilter-Loop: Reflected

Hi Gregory,

On 3/4/2025 1:19 AM, Gregory Price wrote:
> On Thu, Feb 27, 2025 at 11:32:26AM +0900, Honggyu Kim wrote:
>>
>> But using N_MEMORY doesn't fix this problem and it hides the entire CXL
>> memory nodes in our system because the CXL memory isn't detected at this
>> point of creating node*.  Maybe there is some difference when multiple
>> CXL memory is detected as a single node.
>>
> 
> Hm, well, the node is "created" during early boot when ACPI tables are
> read and the CFMW are discovered - but they aren't necessarily "online"
> at the time they're created.
> 
> There is no true concept of a "Hotplug NUMA Node" - as the node must be
> created at boot time. (tl;dr: N_POSSIBLE will never change).
> 
> This patch may have been a bit overzealous of us, I forgot to ask
> whether N_MEMORY is set for nodes created but not onlined at boot. So
> this is a good observation.

I didn't want to make more noise but we found many issues again after
getting a new machine and started using it with multiple CXL memory.

> 
> It also doesn't help that this may introduce a subtle race condition.
> 
> If a node exists (N_POSSIBLE) but hasn't been onlined (!N_MEMORY) and
> bandwidth information is reported - then we store the bandwidth info
> but don't include the node in the reduction.  Then if the node comes
> online later, we don't re-trigger reduction.
> 
> Joshua we should just drop this patch for now and work with Honggyu and
> friends separately on this issue.  In the meantime we can stick with
> N_POSSIBLE.
> 
> There are more problems in this space - namely how to handle a system
> whereby 8 CXL nodes are "possible" but the user only configures 2 (as
> described by Hyonggye here).  We will probably need to introduce
> hotplug/node on/offline callbacks to re-configure weights.
> 
> ~Gregory

This work won't take a long time so I think we can submit a patch within 
a few days.

Thanks,
Honggyu

