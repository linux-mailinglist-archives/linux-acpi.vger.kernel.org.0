Return-Path: <linux-acpi+bounces-18288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A387C155C2
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 16:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2D53A8D21
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A4633C520;
	Tue, 28 Oct 2025 15:08:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7233B978;
	Tue, 28 Oct 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664119; cv=none; b=Q7jpnJuWuqc1nTc7u/eitHTp40kjuEI6W1yo9v/WgXpwligWeKe+aK0EI08UgksaAWx9E9r4McC6LfQBviA8PQmamXHbBsIEin/+wUStYH7dS0auV1LQ8X1PwWHx15l2tL9MwStdj7YxaRs7nl35/hYkyLTvI2ZvQpMZOtmvO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664119; c=relaxed/simple;
	bh=dTbcHDn+RO3JFyZiIfTVSmVikKP62pzNO34OdD97sBg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiLWAHs/tqDf62tk6oEaTbRZfvbSi18CEEnSavhF6mnUHs4sH6iEl9wbaDzCLcPEqCjdFq9G2MR63DPfBP+ujN9/TpH1uZU1aqYa8h3B0WpSeA6vrI0lrbJnsyiak5nsKIx6mu0Y+q0bpYshnD+ky12m+8DxjZRrXiKoLMGWYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwty44dY4z6L4sL;
	Tue, 28 Oct 2025 23:06:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BE9C71400C8;
	Tue, 28 Oct 2025 23:08:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 15:08:31 +0000
Date: Tue, 28 Oct 2025 15:08:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>
Subject: Re: [PATCH v3 1/2] acpi/hmat: Return when generic target is updated
Message-ID: <20251028150830.00000c64@huawei.com>
In-Reply-To: <20251017212105.4069510-2-dave.jiang@intel.com>
References: <20251017212105.4069510-1-dave.jiang@intel.com>
	<20251017212105.4069510-2-dave.jiang@intel.com>
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

On Fri, 17 Oct 2025 14:21:04 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> With the current code flow, once the generic target is updated
> target->registered is set and the remaining code is skipped.
> So return immediately instead of going through the checks and
> then skip.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

