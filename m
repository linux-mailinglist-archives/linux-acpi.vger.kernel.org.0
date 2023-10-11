Return-Path: <linux-acpi+bounces-592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E37C5722
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 16:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C4F282257
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEC515EB2
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE110DF6C;
	Wed, 11 Oct 2023 13:40:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBAEA4;
	Wed, 11 Oct 2023 06:40:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5DNG58Fvz6JB5N;
	Wed, 11 Oct 2023 21:37:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 14:40:37 +0100
Date: Wed, 11 Oct 2023 14:40:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<yazen.ghannam@amd.com>
Subject: Re: [PATCH v6 0/5] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error
 types
Message-ID: <20231011144036.00004376@Huawei.com>
In-Reply-To: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
References: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 10 Oct 2023 15:02:49 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> v6 Changes:
> 	- Reworked to have CXL error types under /sys/kernel/debug/cxl (Dan)
> 		- Removed CXL error types from legacy EINJ interface in favor of
> 		new interface
> 	- Removed cxl_rcrb_addr file
> 	- Added optional patch for CXL error type #defines (patch 2/5)
> 	- Changes to documentation updates to match rework
> 	- Change base to cxl-fixes branch

New approach looks good to me and I took a look at the implementation.
Couldn't find any problems to call out in the individual patches. 
Feel free to add

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> The new CXL error types will use the Memory Address field in the
> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> compliant memory-mapped downstream port. The value of the memory address
> will be in the port's MMIO range, and it will not represent physical
> (normal or persistent) memory.
> 
> Add the functionality for injecting CXL 1.1 errors to the EINJ module,
> but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
> Instead, make the error types available under /sys/kernel/debug/cxl.
> This allows for validating the MMIO address for a CXL 1.1 error type
> while also not making the user responsible for finding it.
> 
> Ben Cheatham (5):
>   cxl/port: Add EINJ debugfs files and callback support
>   ACPI: Add CXL protocol error defines
>   EINJ: Separate CXL errors from other EINJ errors
>   cxl/port, EINJ: Add CXL EINJ callback functions
>   EINJ: Update EINJ documentation
> 
>  Documentation/ABI/testing/debugfs-cxl         |  27 ++++
>  .../firmware-guide/acpi/apei/einj.rst         |  12 ++
>  drivers/acpi/apei/Kconfig                     |   3 +
>  drivers/acpi/apei/einj.c                      | 149 ++++++++++++++++--
>  drivers/cxl/core/port.c                       |  84 ++++++++++
>  drivers/cxl/cxl.h                             |  10 ++
>  include/acpi/actbl1.h                         |   6 +
>  7 files changed, 281 insertions(+), 10 deletions(-)
> 
> base-commit: c66650d29764e228eba40b7a59fdb70fa6567daa


