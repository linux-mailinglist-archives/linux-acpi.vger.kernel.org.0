Return-Path: <linux-acpi+bounces-18080-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870FBFB59D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0AE1892C9D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293C31A54C;
	Wed, 22 Oct 2025 10:14:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EE31B133;
	Wed, 22 Oct 2025 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128074; cv=none; b=DUsutw7SnOOmDUswKHiCuDLuQ0y+PfQzKeMeY4OZvxH453WAjJiKkiVT3UWTo6tJd6Wy9TtUIlgyiX6mSde3n5icrO39ZlswGyna68CQcaYOVZLQmbIwoc8hqmkrJnE9GsHEOhnEZAYiTGNW22wHpqIctWGv+bJ6ksv3dvfzeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128074; c=relaxed/simple;
	bh=jK9NHvFqOq8hS/pN8CgxIiiK2bTriD2UWN8zrHq+pEw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfzmLxIT/rSb/shQv7fhQKwfjk604ebG7sPUfTSTON6NmTwsc5whmNYSL3hMYJXCagvje+59ZY38xUDa4fZXxnhgY2BvnOJAS7EhnDcG06T1faplHAsZTdum1tKyfBnV/GkL2kdjER4If/VKtMo5D33c2jIB4hzlXwxc04RPf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cs4gF2PhWz6J7Z8;
	Wed, 22 Oct 2025 18:10:49 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 321901402FE;
	Wed, 22 Oct 2025 18:14:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Oct
 2025 11:14:24 +0100
Date: Wed, 22 Oct 2025 11:14:23 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, Frank
 Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/2] ACPI: TAD: Improve runtime PM using guard macros
Message-ID: <20251022111423.0000047d@huawei.com>
In-Reply-To: <13881356.uLZWGnKmhe@rafael.j.wysocki>
References: <4698369.LvFx2qVVIh@rafael.j.wysocki>
	<13881356.uLZWGnKmhe@rafael.j.wysocki>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 19:35:54 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use guard pm_runtime_active_try to simplify runtime PM cleanup and
> implement runtime resume error handling in multiple places.
> 
> Also use guard pm_runtime_noresume to simplify acpi_tad_remove().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


