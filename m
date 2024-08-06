Return-Path: <linux-acpi+bounces-7367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E59DA9494DB
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538CAB29FB9
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F607381AA;
	Tue,  6 Aug 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pDRPXg4E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0A21105;
	Tue,  6 Aug 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959328; cv=none; b=WAZ1wKsX1XsSgMX6BVbSrAWkLtMSXvzBnJSHusDejxPxN73yTRlhdL/YuysPgjBSQP1nDodi6RvGNdn4hxQ7vwHR+1TckvWK5Y22+rUvQD77oYa8hWA75ZQEN0ouPWuo31WzDVpiBk8NTEh0dZ1NUDWL7vxrKekQeuoFDbndbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959328; c=relaxed/simple;
	bh=LQSlOEeRpia51mks7wM1PoSQ6VCjEvqr9gvKV9MUKe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMakHukoWKglIR4UwzivUR7zinGxFqZmXk/c51EQbibrDP7ogpNNapOt14wrOAkD/lvuQIuUq1zPpEK6Zjur3uYTZI77e9oP2u/p/Oq6H0zR7Dlki+AdaxVbbgWWnzLdY6r4DxVgB9YNYLjdvOReviW6pmuJokSruds/CEgeBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pDRPXg4E; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=s1a9a
	AuiBzsbZG/XjQxHazfEVtr8j/hhLtoCBAGHVDE=; b=pDRPXg4ELyr3Ry7kw1TKV
	Efy4a04hXu0vhtpVWhYJ7uD3dQiJHUftRiA1z//pM4x+Idx0zSNPjxWDNsDFBOgn
	KA+qgTrpIeWewl+pIS7359obkLurVMeELAY46Fe2l52KKpAS73uCyxi6fJVcWtnU
	RDkYFrawynUoPAncxZuDB4=
Received: from nilq-virtual-machine.. (unknown [60.27.227.124])
	by gzsmtp2 (Coremail) with SMTP id pikvCgD3n07HQbJmk6QOAA--.4296S2;
	Tue, 06 Aug 2024 23:31:21 +0800 (CST)
From: niliqiang <ni_liqiang@126.com>
To: jean-philippe@linaro.org
Cc: Jonathan.Cameron@huawei.com,
	baolu.lu@linux.intel.com,
	devicetree@vger.kernel.org,
	eric.auger@redhat.com,
	guohanjun@huawei.com,
	iommu@lists.linux-foundation.org,
	jacob.jun.pan@linux.intel.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	lenb@kernel.org,
	linux-accelerators@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lorenzo.pieralisi@arm.com,
	rjw@rjwysocki.net,
	robh+dt@kernel.org,
	robin.murphy@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	sudeep.holla@arm.com,
	vivek.gautam@arm.com,
	wangzhou1@hisilicon.com,
	will@kernel.org,
	zhangfei.gao@linaro.org,
	zhukeqian1@huawei.com,
	ni.liqiang@zte.com.cn,
	li.zhichao@zte.com.cn,
	jin.qi@zte.com.cn
Subject: Re: [PATCH v14 07/10] iommu/arm-smmu-v3: Maintain a SID->device structure
Date: Tue,  6 Aug 2024 23:31:19 +0800
Message-Id: <20240806153119.8089-1-ni_liqiang@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20210401154718.307519-8-jean-philippe@linaro.org>
References: <20210401154718.307519-8-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pikvCgD3n07HQbJmk6QOAA--.4296S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr13KryUZF15Kw4rZr4xWFg_yoW3Cwc_KF
	yDZrn7Jw4SyF48XanxKanruwsxKF40g34kX345XrWS93W7JFs8GrykGr9aqrZ7WrZrCwnI
	yrn3ta9xWr1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU14xRPUUUUU==
X-CM-SenderInfo: xqlbzxxtld0wa6rslhhfrp/1tbirwoz5WVLbKD00wAAs2

> It is expected that a single SMMU instance is highly likely to have more 
> than one device behind it, and therefore more than one StreamID to keep 
> track of.

Thanks for your explanation. I now understand the role of the `mutex_lock` statement.
However, I have a new question that I hope you can help me with: I noticed that the
function `arm_smmu_insert_master`, which includes the `mutex_lock` statement, was
introduced in Linux version 5.13. For kernel code before version 5.13, how do we
ensure that there's no resource contention when multiple devices are loaded
behind a single SMMU instance?

Currently, we're indeed encountering resource contention issues when loading
multiple device drivers on the 5.10 kernel. Do you have any suggestions on
how to resolve this issue?

Thanks.


