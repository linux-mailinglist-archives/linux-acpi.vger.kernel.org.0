Return-Path: <linux-acpi+bounces-12740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8FA7BA04
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF448189C7CE
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA471ACEC7;
	Fri,  4 Apr 2025 09:33:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B71A8F79;
	Fri,  4 Apr 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759208; cv=none; b=e2IQdr60EGnZ3Rd6eKD54yEqykgYhbg8hjeVYK3voEAOO54RZkNJLEyXwr67EGkQdqiKNsCf7YBm7GA957ehDsbFbNYfIuSB7QQl9qmK5U1jyyN4P9Mnuay13nfXoMYRnDer4FuWeolS0X05X6l9KAAgr2dBPzLfZajYZ6N3A4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759208; c=relaxed/simple;
	bh=OlwY32Fbx2TlVbmK0WPgwwu2UwN+JSBPC0gU3EjSsdI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phm+04C2YxXlduBOAtDQQ8c9TZBXdzRiF2KNOCAieo728sWrIM3aqFq79Qyi6WHnZ+7Jqc7AxvqjEuQHl0N0CPD+8jFALyh/6pVXDypEaMcsOc7lE1JJ2CIZkmLvGGkASnoFHj4if/g7K9xroe0mMEtcbpt5zZQ0Rwwysf5n3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTYGb06R4z6K61Z;
	Fri,  4 Apr 2025 17:29:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 31004140498;
	Fri,  4 Apr 2025 17:33:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 11:33:22 +0200
Date: Fri, 4 Apr 2025 10:33:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <20250404103321.0000035d@huawei.com>
In-Reply-To: <20250403231339.23708-10-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
	<20250403231339.23708-10-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  3 Apr 2025 16:13:39 -0700
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Add documentation for the updated ACPI specs for EINJv2(1)(2)
> 
> (1) https://github.com/tianocore/edk2/issues/9449
> (2) https://github.com/tianocore/edk2/issues/9017
I forgot to highlight these should probably be link tags as per
earlier patch review.  Other than that, looks good.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

