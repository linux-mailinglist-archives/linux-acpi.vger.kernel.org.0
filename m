Return-Path: <linux-acpi+bounces-12735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9FA7B9BD
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B23B5B60
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73FC1A314E;
	Fri,  4 Apr 2025 09:20:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18091A3144;
	Fri,  4 Apr 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758457; cv=none; b=t5/koQe2f5OwIqfOp79EiV7xJ4q5ywaeCodViEbcCtxsyIM90/qCzL8x9nfT8/bV4gGXozMUqcpx48tiUX56Xo63Wnsf0H4ExW4cmsyECld7Fn9wsn2mWrpiLSx6q9QVIN6e5G4S/UmFD727vKnoMV3q0esJeLJ5K+cPFTBRtdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758457; c=relaxed/simple;
	bh=/qhPQqDfPIlOx7DCzaQ3g+N4TaadMGauJvk2V7rJTEg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wnnr+uGgEsouy/pBms0d/2MOuao5QP1h9uOsGg9q/K39oei8lIM3KsB3BJix8JESpYS9nIe7WRh5ZsQIUK9/m83we18H++2T2kpUlEm01fSfFgFiGEOeUQhUCxG8ZhxfFwKF+je71PWwK1t+q9KQbF8A/InIwMaO2BOhRMK3OJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTY3Y5c5Kz67QRQ;
	Fri,  4 Apr 2025 17:20:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A7F9E14080B;
	Fri,  4 Apr 2025 17:20:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 11:20:50 +0200
Date: Fri, 4 Apr 2025 10:20:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <20250404102049.0000308c@huawei.com>
In-Reply-To: <20250403231339.23708-4-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
	<20250403231339.23708-4-zaidal@os.amperecomputing.com>
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

On Thu,  3 Apr 2025 16:13:33 -0700
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

Probably don't need to mention robot in the commit title.

> This patch fixes the kernel test robot warning reported here:
> https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/

Good perhaps to use the tags suggested in that message.
That helps acknowledge the usefulness of that service and them
tracking the closure of reports.

> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Otherwise you fixed the one thing I pointed out in v4 so
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

