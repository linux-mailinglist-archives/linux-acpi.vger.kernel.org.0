Return-Path: <linux-acpi+bounces-5965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956098CD6CE
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B1D1C2154C
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA385D29B;
	Thu, 23 May 2024 15:14:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74798DDB8;
	Thu, 23 May 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477245; cv=none; b=sMB2+U4KhXHLck1MKuLradgL2KGI+BJkm4IWr484vjJzShYmR/2Xdzh9f0NrafBEKiBFI5O1TfcN3r6XxWUdFXAAcp5DUR9VESyD4t2FxhFiM53Ms0/uGMzaBePZ82HMN7e+94nBa7gNpKgAuCJtgBeKs7NZVzLOdZV+82zYjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477245; c=relaxed/simple;
	bh=SQE2i0yMAkLmu1dTnE6gJPQncGEH1UEWiMQDHn0szng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRrv0zrI4wRhPPdT6Ags4MViTBV4B20soS7p91EqOnDlWJFPGAvwFCBaq8wFo8zfT5VmwQq85nhvcWGztt9TnSbAlbQZ1DB9bU+wKJmDzB/kv8Ij6JzUBSUVVgM0WYKllpfZg6AvrwB++SeeG2anUKto1qj6CaLWN4GbDf/1NrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlWnP1XzHz6JB16;
	Thu, 23 May 2024 23:10:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9467D140A1B;
	Thu, 23 May 2024 23:13:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 16:13:59 +0100
Date: Thu, 23 May 2024 16:13:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<Benjamin.Cheatham@amd.com>, <dan.j.williams@intel.com>, <arnd@arndb.de>,
	<Avadhut.Naik@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<john.allen@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [RFC PATCH v2 3/8] ACPI: APEI: EINJ: Remove redundant calls to
 einj_get_available_error_type
Message-ID: <20240523161357.00007532@Huawei.com>
In-Reply-To: <20240521211036.227674-4-zaidal@os.amperecomputing.com>
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
	<20240521211036.227674-4-zaidal@os.amperecomputing.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 21 May 2024 14:10:31 -0700
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

