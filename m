Return-Path: <linux-acpi+bounces-16536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EB0B4FEF2
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 16:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6237BB007
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42896274FFD;
	Tue,  9 Sep 2025 14:06:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EE2367BA;
	Tue,  9 Sep 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426809; cv=none; b=i8MQi9RC1WIlDZ4ZWkSa/vN0VaBWpLMtFc2PGQW1xRdEjbNoBMLgo3gQa0h9A7kuG94HNgKT5fLvbtiWYqzW9TZzobaj3yuvMGVh+cG0uxVwwQ5kk4bjgz9+Ub5KJbAlsQKHXUpt2YiaRQ86xm+N0Kfa2O/sMOGxcz+QliPEKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426809; c=relaxed/simple;
	bh=kK4qlT+CRQW6c+NgMgSfzghLPuENtOVYb49g7rHPttk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owgwq67cn12saG+mAfkSYnGztqyMewDA4EsdFKoFfeO86LkMamBGdHfaewsy2qt+oBvSgYSQQTwUs9kHB7YGko57GonhsZzS6BgEPPGEFK6Lo04qaxb5KyIWqm5JW16Nt2bFJZvB6/XCL6NFXlrSVRvRfgYIqLLa+rfjWPC/Abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLlrR56TQz6L538;
	Tue,  9 Sep 2025 22:02:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 281D9140278;
	Tue,  9 Sep 2025 22:06:39 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 16:06:38 +0200
Date: Tue, 9 Sep 2025 15:06:36 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <rafael.j.wysocki@intel.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<ira.weiny@intel.com>, <alison.schofield@intel.com>,
	<a.manzanares@samsung.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cxl/acpi: Rename CFMW coherency restrictions
Message-ID: <20250909150636.000036b3@huawei.com>
In-Reply-To: <20250908160034.86471-1-dave@stgolabs.net>
References: <20250908160034.86471-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  8 Sep 2025 09:00:34 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc
> 
> This has been renamed in more recent CXL specs, as
> type3 (memory expanders) can also use HDM-DB for
> device coherent memory.
> 
> Link: https://github.com/acpica/acpica/commit/710745713ad3a2543dbfb70e84764f31f0e46bdc
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

