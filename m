Return-Path: <linux-acpi+bounces-12738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F710A7B9DA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A202E189B4A0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504691A5B9D;
	Fri,  4 Apr 2025 09:25:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0728F4;
	Fri,  4 Apr 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758721; cv=none; b=mCUh7HlL2Z/B/+/oZasUhqgs+Zw3ErM4d0ZMlY+R/JJ1jAfYKOkTqqxXrpdJ+SAJwV1f96G+9AEMINIpATs6/3shmuLIGMPX5ECxow60jrEH/0GYAOI76j0orQ3DVSZgyNQutGqeeRJL0kDisB5MMAwKmfG+hVhPp/jMIjsvxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758721; c=relaxed/simple;
	bh=3bLz7Tfp+XzEUJayA7IeDeEi//GK7Dibow6Rv/WqPY4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGPLUrQWCagBQXZs0nuhYjR2JvKySdFDbFXzZi0XyDJ6pUPXypXnw3COKnWj1ScStofHceKmuOC61RSyJrMa3+PbgWeeu9sa+99ydjh+xtVhkE5QFWG+gDfUs0Mx1oEf33q02IwmOvF+XrW9QO/j6Xu63BmCG83TBK3U7S/vRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTY5D1T7pz67HSr;
	Fri,  4 Apr 2025 17:21:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C2D8D140802;
	Fri,  4 Apr 2025 17:25:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 11:25:17 +0200
Date: Fri, 4 Apr 2025 10:25:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 0/9] Enable EINJv2 Support
Message-ID: <20250404102515.0000222b@huawei.com>
In-Reply-To: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
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

On Thu,  3 Apr 2025 16:13:30 -0700
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> The goal of this update is to allow the driver to simultaneously
> support EINJ and EINJv2. The implementation follows the approved
> ACPI specs(1)(2) that enables the driver to discover system
> capabilities through GET_ERROR_TYPE.
> 
> Note: The first two ACPICA patches are to be dropped once merged in
> ACPICA project, see pull request(3).
> 
> (1) https://github.com/tianocore/edk2/issues/9449
> (2) https://github.com/tianocore/edk2/issues/9017
> (3) https://github.com/acpica/acpica/pull/977
> 
> Note: This revision includes a minor change to the user interface,
> where users no longer input component array size, instead the size
> of the array is parsed by counting lines from user input.
No change log here or in patches.  Ideal is a summary of the big
stuff here and details under the --- in each individual patch.


> 
> Zaid Alali (9):
>   ACPICA: Update values to hex to follow ACPI specs
>   ACPICA: Add EINJv2 get error type action
>   ACPI: APEI: EINJ: Fix kernel test robot sparse warning
>   ACPI: APEI: EINJ: Remove redundant calls to
>     einj_get_available_error_type
>   ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
>   ACPI: APEI: EINJ: Add einjv2 extension struct
>   ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
>   ACPI: APEI: EINJ: Enable EINJv2 error injections
>   ACPI: APEI: EINJ: Update the documentation for EINJv2 support
> 
>  .../firmware-guide/acpi/apei/einj.rst         |  33 +-
>  drivers/acpi/apei/apei-internal.h             |   2 +-
>  drivers/acpi/apei/einj-core.c                 | 322 +++++++++++++-----
>  drivers/acpi/apei/einj-cxl.c                  |   2 +-
>  include/acpi/actbl1.h                         |  25 +-
>  5 files changed, 291 insertions(+), 93 deletions(-)
> 


