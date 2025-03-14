Return-Path: <linux-acpi+bounces-12235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10DA60E75
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 11:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBFF16098C
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73381F428D;
	Fri, 14 Mar 2025 10:12:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7781F3BB2;
	Fri, 14 Mar 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947153; cv=none; b=D6UuHkdUqnH1A1llozCwoavjxCiF3WSDlru8YA4ea5vChopiZg5PWLPzNEo6DSCrImtjbzoVEzKhyGibqmDGtn0AuRzRt8m5LzNWeIfzjeu8TtpuCsHUOUxhb8mdnXPwzOfm70nd8VLWOzUkip+zVcTRDtW1rgzLiEhDrfz+es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947153; c=relaxed/simple;
	bh=TuNwZbXOlp8yH3oYznGzycF2Huzd0afoCR8oHtR6Sv4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec+HjM2kg4XC64T+JlPHQf5msjFdLREf7lSsTX7f9tWLnsr+YZPdhDbCjXgV3s3uGH0st2U/Q5EDhYa4LOTTD9g26/8jHG2QNLiN2MU2sXJRzloqgCi5asDrlRslTiGWg9jJISvtbKeJpTOynkfMh/ItaBQyGFmAwHg+apogo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDg7x59l3z6J7rg;
	Fri, 14 Mar 2025 18:09:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE8E140A70;
	Fri, 14 Mar 2025 18:12:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 11:12:28 +0100
Date: Fri, 14 Mar 2025 10:12:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <rafael@kernel.org>,
	<lenb@kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>,
	<bfaccini@nvidia.com>, <rppt@kernel.org>, <haibo1.xu@intel.com>,
	<chenbaozi@phytium.com.cn>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <20250314101226.00003830@huawei.com>
In-Reply-To: <Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
	<Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Mar 2025 11:02:37 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> > @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  	start = cfmws->base_hpa;
> >  	end = cfmws->base_hpa + cfmws->window_size;
> >  
> > +	if (srat_disabled()) {
> > +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> > +		return -EINVAL;
> > +	}
> > +  
> 
> I thought the srat was optional regardless of the presence of a CFMWS.
> Is this not the case?

True in theory, but do we want to support it?

I'd vote no unless someone is shipping such a system and can't fix it up.

Jonathan


> 
> ~Gregory
> 


