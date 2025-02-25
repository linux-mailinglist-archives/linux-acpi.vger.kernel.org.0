Return-Path: <linux-acpi+bounces-11461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88794A4422B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731963BCAB0
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B426A084;
	Tue, 25 Feb 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="fYjU33Vr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D626157A;
	Tue, 25 Feb 2025 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492697; cv=pass; b=H4eZE4KOfeylxnhcAzx/wEVH4TBEbgda2/RQzWNYTbnVFwZcWL0L117/IyduJ+UKv+16rzQ8OTlJS4oMM3uo/hYZS+DtOwvIEfZ7zhWDWz23rSqCPQz0TcckmAHEVe1Jk8UYnKbl8CY6L67UHgUghOmcgPBHnnSO9JGa4H9iFv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492697; c=relaxed/simple;
	bh=rltcG+xLwaBVbPkYITsGEgOuFXoVdF1rKnPjDdojj0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2amk7tTVt6b/AtK5zmhOdpBKopOorqp2Z8873wmlqAdcbykS+pzGKVSnoe/8i64ja8h+I9jtfkZHg6ohrvnN7F9pbKIZ82BODrQV0GvnXNdcodPHxPoPT8dWRi0QEnhkNqVVcvyO8G8QuGdtbqaA+EA7ndncKwkNzVg76nxgBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=fYjU33Vr; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1740492665; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PbTuL9JYEdhR+1DlCsU/l9bucAQI92NAOtt8Qe+r15OVw0/JS2D/lJT6rLxgzaXlS46TPhMtPNpx0WlicWs3FiUrjcVLP/Puu7ssR5kTifBuBkj/fTwjXcLgaJkaB8VXfe5CuhyzPwIWlU5Ypu5wjHn8rxiAzx4fYJM1MZht/F0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740492665; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rltcG+xLwaBVbPkYITsGEgOuFXoVdF1rKnPjDdojj0s=; 
	b=Hb8+QlQdgu0nOX4bepDKbjVq/PL7QPeDKOWnrW9WK+O4s7wRXFuyyuk2wtcW25qNlOeWvGb5rak58Sb7TeaFXnuZfFb4ISz4UWQu5nnOpZ4F0hsKyZu16s9xuDqTafbqm++Lb/i+2p8LiEMU/Jp38sPzSYJE1hlPyFaJFzQIV0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740492665;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=rltcG+xLwaBVbPkYITsGEgOuFXoVdF1rKnPjDdojj0s=;
	b=fYjU33Vro49VEj7mQl4vjf0O1xSf1mJdFjACW+8dRDoKJhqXd0iWs8FyMPk1/vxg
	KHHt5NjIw71O74nGZswZYeAgaG3qHg7yIG+D+KivHUxv4g5pCnTfE4UxVHV6bN3ykqb
	wZgzV/0bjVo9Ss6bSaRkwrFFjAyYj1AtjFXEve2A=
Received: by mx.zohomail.com with SMTPS id 1740492663139710.446979599864;
	Tue, 25 Feb 2025 06:11:03 -0800 (PST)
Message-ID: <766e5af8-086f-4d92-8275-8d30727b08ad@zohomail.com>
Date: Tue, 25 Feb 2025 22:10:57 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] cxl: Add extended linear cache address alias
 emission for cxl events
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com
References: <20250224182202.1683380-1-dave.jiang@intel.com>
 <20250224182202.1683380-4-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250224182202.1683380-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122757608cca4fd08332c6c99343000065caa20ab71a55ebce4c59cebac0e41de6c989af914e7554ff:zu080112270acd51632aed8b0fbb3deb9e00008f16c2b7dfafb28acc8504242f397571e03b4631316193b014:rf0801122dfb0a5394eec25c8a634069ad000081aba720df53b48a0cd62f6c87d86f3b714bd2fb8bb2b8803fff3d9d3521cd:ZohoMail
X-ZohoMailClient: External

On 2/25/2025 2:21 AM, Dave Jiang wrote:
> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

