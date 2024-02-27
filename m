Return-Path: <linux-acpi+bounces-3985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66F869D9B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DFE1F21629
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41894EB21;
	Tue, 27 Feb 2024 17:25:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9E4E1A0;
	Tue, 27 Feb 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054724; cv=none; b=fgtsYq4PpmKGBbwMrdB2d4xfy1qqlwk7G7GkZnsKs/LfvT1n5wK2dbfRMFOMkgA5SXX2qskLlY0/ybg+IYd9SBNHd7b7NTCX+PaE5x/Gprg9Q7x3ORhiFyML0hTrtSle+qHGWVLeLzTybANHz7F9VixR1bffkpMjzsWeY5fM0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054724; c=relaxed/simple;
	bh=r34YLYQKSKx3sWuiPSTLFJqef2Rioz3nuQfho1GAHmc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gjdx53ns5zJd/uGXzhDie2fE8YfZu1466G6FcrpUyiA7ne2MNmBzjuT873tbHG76Ts9hbOOAc2b0LzzbrrG3FDXluUEvB2//36tHhV8IIz7NWbppOCpRwAj6b1D7qtOo/BNvoilfwEAJkQPciAqrrulNbI15lMrMCTTWpiV8tWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tkklt1LgWz67bhc;
	Wed, 28 Feb 2024 01:20:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7576914110A;
	Wed, 28 Feb 2024 01:25:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 17:25:19 +0000
Date: Tue, 27 Feb 2024 17:25:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 05/12] cxl: Split out combine_coordinates() for
 common shared usage
Message-ID: <20240227172519.00006b55@Huawei.com>
In-Reply-To: <20240220231402.3156281-6-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
	<20240220231402.3156281-6-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Feb 2024 16:12:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Refactor the common code of combining coordinates in order to reduce code.
> Create a new function cxl_cooordinates_combine() it combine two 'struct
> access_coordinate'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


