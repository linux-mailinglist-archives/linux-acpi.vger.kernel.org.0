Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057A23A2489
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 08:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFJGc4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 02:32:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53256 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhFJGcz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 02:32:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A6I0bY023582;
        Thu, 10 Jun 2021 06:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jmv9dMHpJzbTvHPIEC9RUwKK2b0+RbpO0gWzBaQjnPA=;
 b=rvB3TUyfEdXytYeS9BC3SDJGTC69GpTrLTnpi9EA9KjGyQI+91nUN1a67f0239YOt57a
 XPpZDeGPF0drBHqaMAy8FN8zILVSr+mnQqa7BWF0jjiS9ya06GP7BryL9K+t7rWNgTQE
 l1ABv/Mn0sqE2ri4034nUxJ9qzEeTqNfuk2kxSzYRL7FCjFrFcCskoJxMJHjJeqEDDte
 2+8jF+igGpmIQc9TGg+5jOesqtnrTC56RSRPICURf+yxWQH6r23mfC//3cDucog+6THv
 1sLAwI4LFyytenFOX2PWRDFRnjHncowN01Q76bYLdPHn3tQv1ZKWKkC6DsLv+hDmUAi/ PA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 392jmw0j8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 06:29:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15A6TqOg169680;
        Thu, 10 Jun 2021 06:29:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 390k1smbfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 06:29:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15A6Tp3K169666;
        Thu, 10 Jun 2021 06:29:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 390k1smbfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 06:29:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15A6TnRH020945;
        Thu, 10 Jun 2021 06:29:49 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jun 2021 23:29:49 -0700
Date:   Thu, 10 Jun 2021 09:29:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] ACPI: scan: ensure ret is initialized to avoid
 garbage being returned
Message-ID: <20210610062939.GI1955@kadam>
References: <20210609173312.298414-1-colin.king@canonical.com>
 <CAFLoDVE03-Eqmrji66P-b79ezgD0PayWqO5u3L7nyjMX1+LBtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLoDVE03-Eqmrji66P-b79ezgD0PayWqO5u3L7nyjMX1+LBtg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: edcHlkvzb8oDBi8lztWaSoIhhRFPQJ5t
X-Proofpoint-ORIG-GUID: edcHlkvzb8oDBi8lztWaSoIhhRFPQJ5t
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 09, 2021 at 10:38:04PM +0100, Daniel Scally wrote:
> Hi Colin
> 
> On Wed, Jun 9, 2021 at 6:33 PM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > In the unlikely event that there are no callback calls made then ret
> > will be returned as an uninitialized value. Clean up static analysis
> > warnings by ensuring ret is initialized.
> 
> Ah, thanks - good spot.
> 
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: a9e10e587304 ("ACPI: scan: Extend acpi_walk_dep_device_list()")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Reviewed-by: Daniel Scally <djrscally@gmail.com>
> 
> I'm still bad at Git; will the commit hash here be right, since the
> patch that this fixes isn't upstream yet?

The hash is stable unless the branch rebases.  When maintainers rebase a
branch, they're expected to update the Fixes tags as well.  Most people
probably have a script to do it.  I think Stephen Rothwell has a script
which checks whether Fixes tags are correct?

regards,
dan carpenter

