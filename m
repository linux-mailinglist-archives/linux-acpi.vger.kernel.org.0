Return-Path: <linux-acpi+bounces-12232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F357EA60D3B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A85460B11
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033361E633C;
	Fri, 14 Mar 2025 09:27:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AE1C861D;
	Fri, 14 Mar 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944430; cv=none; b=dIhz7GSeoJ9fWJPYCXSzAS9eEB6xZuDBhClLag+YhqYQ0hDZBqwk0N9moUgD2PIZEzFNZj1gEq9c7LScZUQ598vM7DXPuhcXUJsIrU9a9uHSbtmHuwyGgTcXc1dZA4ZbHtpEw1n98Wig8CqzbRn4bKTH5g2EUmtlF+TIMCW+7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944430; c=relaxed/simple;
	bh=PqUbDXVDaiUum+Dew0MC5ziN5yYPu9hhy423HzIFiWY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpH3ng9OjSGhIUyBVPk4RrPwi3/dFN01eRzl/X9FisMb/vlhrgz2yeiewhcoQuveBQkqN1qzZnf/MQ1oPdkmuojTWlPRR03KqiwvBRP7W5daBdCsfbW2cH0AlpjkiVIWMkfoTz5tZk4vEezlz1LQ5foFCh37hTHBsLvfnqoNZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDf7b3c1Yz6J7qr;
	Fri, 14 Mar 2025 17:23:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F87C1400CD;
	Fri, 14 Mar 2025 17:27:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 10:27:05 +0100
Date: Fri, 14 Mar 2025 09:27:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <20250314092704.00006ffe@huawei.com>
In-Reply-To: <Z9M6ryapTGlBWA3Q@zaid-VirtualBox>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-7-zaidal@os.amperecomputing.com>
	<20250313094230.00004696@huawei.com>
	<Z9M6ryapTGlBWA3Q@zaid-VirtualBox>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Mar 2025 13:06:07 -0700
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> On Thu, Mar 13, 2025 at 09:42:30AM +0000, Jonathan Cameron wrote:
> > On Thu,  6 Mar 2025 15:48:07 -0800
> > Zaid Alali <zaidal@os.amperecomputing.com> wrote:
> >   
> > > Add einjv2 extension struct and EINJv2 error types to prepare
> > > the driver for EINJv2 support. ACPI specifications(1) enables
> > > EINJv2 by extending set_error_type_with_address struct.
> > > 
> > > (1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615  
> > Still seems to be down.
> > Also, we have tag for this.  
> > > 
> > > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>  
> > 
> > Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4615 # [1]
> > 
> > 
> > One additional request inline.
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > > ---
> > >  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > > index aee9a7b17313..32b8d102f399 100644
> > > --- a/drivers/acpi/apei/einj-core.c
> > > +++ b/drivers/acpi/apei/einj-core.c
> > > @@ -50,6 +50,28 @@
> > >   */
> > >  static int acpi5;
> > >  
> > > +struct syndrome_array {
> > > +	union {
> > > +		u32	acpi_id;
> > > +		u32	device_id;
> > > +		u32	pcie_sbdf;
> > > +		u8	vendor_id[16];
> > > +	} comp_id;
> > > +	union {
> > > +		u32	proc_synd;
> > > +		u32	mem_synd;
> > > +		u32	pcie_synd;
> > > +		u8	vendor_synd[16];
> > > +	} comp_synd;
> > > +};
> > > +
> > > +struct einjv2_extension_struct {
> > > +	u32 length;
> > > +	u16 revision;
> > > +	u16 component_arr_count;
> > > +	struct syndrome_array component_arr[];  
> > 
> > __counted_by(component_arr_count);
> > should be fine and marking these is always good to do in
> > new code (and old code if you have time!)  
> 
> I am not sure if __counted_by is appropriate here. Please note that component_arr_count
> is set by the user and does NOT represent the size of the component_arr[].

Does it represent the length that should ever be accessed (which is what
the __counted_by() stuff will help us find bugs around).

If not that wins an award for misleading naming :)

Jonathan


> > 
> >   
> > > +};
> > > +
> > >  struct set_error_type_with_address {
> > >  	u32	type;
> > >  	u32	vendor_extension;
> > > @@ -58,6 +80,7 @@ struct set_error_type_with_address {
> > >  	u64	memory_address;
> > >  	u64	memory_address_range;
> > >  	u32	pcie_sbdf;
> > > +	struct	einjv2_extension_struct einjv2_struct;
> > >  };
> > >  enum {
> > >  	SETWA_FLAGS_APICID = 1,  
> >   


