Return-Path: <linux-acpi+bounces-3547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79428569DF
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7468328A62A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6A135A71;
	Thu, 15 Feb 2024 16:46:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2A6341F;
	Thu, 15 Feb 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015572; cv=none; b=kcQLTW3XxUAHsth/zmc/G1ZL5vT7RC22jZ9NBEDloM7DuPYR/onKJGkfg5KzUq2AiT58KUuYclqSx2S7yymWDidGeSEhVFTH+m5iUsFdEUl9wkVAW0J+SWW5T6bwIy6EU7odM+54udI872XNlLgfjFi80y0AAqSvaX3DBbxsdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015572; c=relaxed/simple;
	bh=IVroZQowpFgSBHUBJqX9tNVrWST8aeetvc+prYY1J5g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s67RVGVypZl1qYPNaSlzlnjS76jfrmg4KTVbSRdOGuMo9VDdETIE+JYYhJYtIwyuCnCxOsDXLoP6DDzjMO4vWjXzVbz+g9k+o0GhIyf9d8k67rCYhY8T8Wai2HSc4yeoxRfIz7swxipvCEf3zw7U+uGBnW/ogxSx7a5dcRBKqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbLTC5zRXz6K8xR;
	Fri, 16 Feb 2024 00:42:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A90AF1400D4;
	Fri, 16 Feb 2024 00:46:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:46:07 +0000
Date: Thu, 15 Feb 2024 16:46:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 04/12] ACPI: HMAT / cxl: Add retrieval of generic
 port coordinates for both access classes
Message-ID: <20240215164606.000003c5@Huawei.com>
In-Reply-To: <20240206222951.1833098-5-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-5-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Update acpi_get_genport_coordinates() to allow retrieval of both access
> classes of the 'struct access_coordinate' for a generic target. The update
> will allow CXL code to compute access coordinates for both access class.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


