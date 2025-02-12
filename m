Return-Path: <linux-acpi+bounces-11121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39012A32BF1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187E07A2356
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A42257439;
	Wed, 12 Feb 2025 16:37:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03D1E7C19;
	Wed, 12 Feb 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378240; cv=none; b=r/mSqIFpkZGA74OtmO3MSRd1l06lf8Q1JOENUcVVxXs+qID51V5cLovyPZClHLsHjcSx4xwO382z4K4kSxuHfPk3jdkZpZ+N0V/KICYDvpuqhe0r4bGS8np3Y/vIG936JQUAoOoq4k2FeUCCXnejztMXp6LzASF0uIb9b54tpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378240; c=relaxed/simple;
	bh=Kw8B3dUBG9Eghh1JxxFzYc5q2wSxP2wh0YJV67MTC6s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpydowEciQjNNsJG0VfV6kmNnMT/TeUrj9GYIIA8r5JqEkEhr+ip6lbp8kakbxxKJKdRpWN77s0ybCjwZiJPpwvixqozgj1fdns93Hw4Ldm38X/7pIhaxLVa6NfDja5wTE1MR744b6Xm0B53uWw6h6luJKTb2Ds6YbGefepxO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtP6g0hPbz6H7TG;
	Thu, 13 Feb 2025 00:34:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 93583140136;
	Thu, 13 Feb 2025 00:37:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 17:37:15 +0100
Date: Wed, 12 Feb 2025 16:37:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v3 4/9] ACPI: APEI: EINJ: Remove redundant calls to
 einj_get_available_error_type
Message-ID: <20250212163714.00002433@huawei.com>
In-Reply-To: <20250210183705.1114624-5-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
	<20250210183705.1114624-5-zaidal@os.amperecomputing.com>
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

On Mon, 10 Feb 2025 10:37:00 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> A single call to einj_get_available_error_type in init function is
> sufficient to save the return value in a global variable to be used
> later in various places in the code. This commit does not introduce
> any functional changes, but only removing unnecessary redundant
> function calls.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

