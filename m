Return-Path: <linux-acpi+bounces-10297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324519FBFAB
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D4C18847A8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDDA1CD1F1;
	Tue, 24 Dec 2024 15:32:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838B14287;
	Tue, 24 Dec 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735054327; cv=none; b=DllJdo+sOzcjGOZSM5eDm/NUzhveJsOqDgaGCgIafOpbFXIoVpB4ja2IcAy+dv6hFY41P48ZVnONo3wjLxrKV8qKpKMI0n0AUHERPX31xeNbbk4+TWfs9zFrD3A//BIz5Js9R6SeTomYXm4h+ebxzyV5Gxhk9eovOVmnMkhJeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735054327; c=relaxed/simple;
	bh=SejhPelDuau09PXtQdGQAebREK3Age/ltwiMDBCN5SY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IStzzWxrOZNYnnswumEB/z4/v9WQRJdFJHfs27u+WkTts6Rx3gmiAKxQKfjBysnRB+6s2vSsjjPOWClRnmlAi3tUQUNYddzzc+Xzh9ZZgkKqqeuCa7HcKfndWsedb563ij9kMLCbuOSP4AxKrMHA7DupV6m/IzY6WxLmE5alAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHf0p113rz6K5rS;
	Tue, 24 Dec 2024 23:28:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AC9714038F;
	Tue, 24 Dec 2024 23:32:03 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:32:02 +0100
Date: Tue, 24 Dec 2024 15:32:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 4/9] ACPI: APEI: EINJ: Remove redundant calls to
 einj_get_available_error_type
Message-ID: <20241224153200.00001569@huawei.com>
In-Reply-To: <20241205211854.43215-5-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
	<20241205211854.43215-5-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  5 Dec 2024 13:18:49 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> A single call to einj_get_available_error_type in init function is
> sufficient to save the return value in a global variable to be used
> later in various places in the code. This commit does not introduce
> any functional changes, but only removing unnecessary redundant
> function calls.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
ok. I guess this is ok given how many globals are in use in here
already.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

