Return-Path: <linux-acpi+bounces-18742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 388D3C47F35
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8D874EE8C0
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15C27F4CA;
	Mon, 10 Nov 2025 16:27:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4E27E07E;
	Mon, 10 Nov 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792063; cv=none; b=hiO4R+Z/2rRbRVOkcXsSE9mZ4ILcUgS0q6XD6OS+3YYG9dQMp/WbnhZ0Z93Y7fysaLcFDKqOW1CWJgd+/MVQe2tCRz1yFAyOuGjUzryjeKWlVpUR8KIgTCmnduhsspMRFoxLhTnsAdmjH0B25lsec2rHLNzmLTsBoQ+qcgekP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792063; c=relaxed/simple;
	bh=yuxXc0hUihCmRaQ0JrpzqQceEtDX34CLu2mPGMvgV7Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDarfT3b8ySrZI3NSh7LuacsPVwx43UDE9lYfPHTznfvKz37FxYkOBlraWrNgiZi4jy9QV5jpPn8pn+2aTSUyTJ3NWN8VQLKYlf5vE/Ijzp+WMyMAVh+1zhsLdWuAZjlOsR3iiAnRqU1V+yg2Kzl8i5zIGlkCm+nj0I/mJhh4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4w6h674BzJ467T;
	Tue, 11 Nov 2025 00:27:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 58300140446;
	Tue, 11 Nov 2025 00:27:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 16:27:36 +0000
Date: Mon, 10 Nov 2025 16:27:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gavin Shan <gshan@redhat.com>
CC: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>,
	<amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
Message-ID: <20251110162735.00001be9@huawei.com>
In-Reply-To: <835b49a3-cbe2-41b0-a442-f7cabaa644fd@redhat.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-10-ben.horgan@arm.com>
	<835b49a3-cbe2-41b0-a442-f7cabaa644fd@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sat, 8 Nov 2025 18:54:05 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Ben,
> 
> On 11/7/25 10:34 PM, Ben Horgan wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > Add code to parse the arm64 specific MPAM table, looking up the cache
> > level from the PPTT and feeding the end result into the MPAM driver.
> > 
> > This happens in two stages. Platform devices are created first for the
> > MSC devices. Once the driver probes it calls acpi_mpam_parse_resources()
> > to discover the RIS entries the MSC contains.
> > 
> > For now the MPAM hook mpam_ris_create() is stubbed out, but will update
> > the MPAM driver with optional discovered data about the RIS entries.
> > 
> > CC: Carl Worth <carl@os.amperecomputing.com>
> > Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> > Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> > Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > Tested-by: Peter Newman <peternewman@google.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> > ---
> > Changes since v3:
> > return irq from acpi_mpam_register_irq (Jonathan)
> > err -> len rename (Jonathan)
> > Move table initialisation after checking (Jonathan)
> > Add sanity checking in acpi_mpam_count_msc() (Jonathan)
> > ---
> >   arch/arm64/Kconfig          |   1 +
> >   drivers/acpi/arm64/Kconfig  |   3 +
> >   drivers/acpi/arm64/Makefile |   1 +
> >   drivers/acpi/arm64/mpam.c   | 403 ++++++++++++++++++++++++++++++++++++
> >   drivers/acpi/tables.c       |   2 +-
> >   include/linux/arm_mpam.h    |  47 +++++
> >   6 files changed, 456 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/acpi/arm64/mpam.c
> >   create mode 100644 include/linux/arm_mpam.h
> >   
> 
> With the following minor comments addressed:
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
Just picking out one comment where I think your suggestion
isn't quite the right one.

Jonathan

> > diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> > new file mode 100644
> > index 000000000000..c199944862ed
> > --- /dev/null
> > +++ b/drivers/acpi/arm64/mpam.c

> > +static int __init acpi_mpam_parse(void)
> > +{
> > +	char *table_end, *table_offset;
> > +	struct acpi_mpam_msc_node *tbl_msc;
> > +	struct platform_device *pdev;
> > +
> > +	if (acpi_disabled || !system_supports_mpam())
> > +		return 0;
> > +
> > +	struct acpi_table_header *table __free(acpi_put_table) =
> > +		acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> > +
> > +	if (IS_ERR(table))
> > +		return 0;
> > +
> > +	if (table->revision < 1)
> > +		return 0;
> > +  
> 
> It's correct to return zero on IS_ERR(table) with an error message, but
> a message printed by pr_debug() may be worthywhile on "if (table->revison < 1)".
> 
> > +	table_offset = (char *)(table + 1);
> > +	table_end = (char *)table + table->length;
> > +
> > +	while (table_offset < table_end) {
> > +		tbl_msc = (struct acpi_mpam_msc_node *)table_offset;
> > +		table_offset += tbl_msc->length;
> > +
> > +		if (table_offset > table_end) {
> > +			pr_err("MSC entry overlaps end of ACPI table\n");
> > +			return -EINVAL;
> > +		}
> > +  
> 
> Would be:
> 
> 		if (table_offset + sizeof(*tbl_msc) > table_end)

I'm not seeing this one.  table_offset has already been moved on by
tbl_msc->length which should be bigger than sizeof(*tbl_msc).

Could add a check before reading tbl_msc->length that there is enough
there to do so. That to me would make sense (like the other case you point
at later).

Jonathan





