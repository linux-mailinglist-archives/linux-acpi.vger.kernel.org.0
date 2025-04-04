Return-Path: <linux-acpi+bounces-12736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3DBA7B9CA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCE57A79E3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C61A3BA1;
	Fri,  4 Apr 2025 09:22:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA91A3142;
	Fri,  4 Apr 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758559; cv=none; b=REJ6lAz1GFctnMK687s6jLLkcrWi8mBLEpueEcLLvHrDjIyM126HnEW6TtoU1oo6uZzEhy06goc2idnff7n39x4QMaPy5kxflozqxfZVnDPTYEgwmKkiAZllPskR5JpY5nwfYBKsd5stiC7HvCFzEozqfUkmvaH8T5HXo7gDinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758559; c=relaxed/simple;
	bh=sSNH18f/W+FbUtbG++J0r0j2pGwvRnhriM/SxP+8IRM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNpUnkZAMgvupcuDOSkXvfry1sWruukP/o53K6mNqFpP73g/aTdl1CW9m9JtBEIZG89LOQC1Sf5LB2thOcjsAdfeuSkNBlgMNIFRIvrVVUTHVdXB+8Oi82zEYrfPyRv+fcKVdW4EkdYFgZLkQdNMvSKDLHXmhU1f8CgBxk4m6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTY262Mtnz6K9Ct;
	Fri,  4 Apr 2025 17:18:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 778F914062A;
	Fri,  4 Apr 2025 17:22:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 11:22:33 +0200
Date: Fri, 4 Apr 2025 10:22:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <20250404102232.00005501@huawei.com>
In-Reply-To: <20250403231339.23708-6-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
	<20250403231339.23708-6-zaidal@os.amperecomputing.com>
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

On Thu,  3 Apr 2025 16:13:35 -0700
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
I gave a tag for v4. If there is a reason you dropped it then should say
under the ---

Anyhow, at first glance this is the same code so I'll assume that it was
missed by accident and give it again
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

