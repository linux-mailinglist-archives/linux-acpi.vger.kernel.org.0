Return-Path: <linux-acpi+bounces-12741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76541A7BA33
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BBA3B5627
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6751B042E;
	Fri,  4 Apr 2025 09:44:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953911B0413;
	Fri,  4 Apr 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759892; cv=none; b=gpn406d2dRu3yDcsLgQkXzsuqz8V9FBr/SiJ/fql3lEp9+H2zgVZcq+h5ohzRBkcEy2eIQ/BwMFv0ayWLWySY9QnJ1OlOzFY56I/EkKVpVd3rMG25r0VLJgp+RJ2oZ0v7QVb7oNDRJt84X9BI8KzqVFHhWvmDPb/1bFZdohZWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759892; c=relaxed/simple;
	bh=HD7kWkg7XSuXBSb2w/uqNbauod0izeN3YT2dEnrTrM0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOGxiOx9y1v2igMlDo1X4XgVlpxSoFGBLneb5x/bHjgycFxz75vKqMAoJDtr791jJcrvk1Lt7kpHs64KDRX3RFEF7iCoJMY1LEvbxGwzKpSfmrFAaRq8fia/a3QdoMb4AgRKhSO2pfJ20/J1HmjZKDjgqBivfjw+opaOdtPf3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTY5w2qgnz6K5VN;
	Fri,  4 Apr 2025 17:22:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A3B11408E8;
	Fri,  4 Apr 2025 17:25:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 11:25:51 +0200
Date: Fri, 4 Apr 2025 10:25:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2
 support
Message-ID: <20250404102550.00007d3e@huawei.com>
In-Reply-To: <20250403231339.23708-8-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
	<20250403231339.23708-8-zaidal@os.amperecomputing.com>
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

On Thu,  3 Apr 2025 16:13:37 -0700
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Create a debugfs blob file to be used for reading the user
> input for the component array. EINJv2 enables users to inject
> errors to multiple components/devices at the same time using
> component array.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hmm.  Maybe you didn't get my emails?

