Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554EF1249D4
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfLROha convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 18 Dec 2019 09:37:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfLROha (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Dec 2019 09:37:30 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6751A2B9EB2AF1B35A2E;
        Wed, 18 Dec 2019 14:37:28 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Dec 2019 14:37:27 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 14:37:27 +0000
Date:   Wed, 18 Dec 2019 14:37:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brice Goglin <brice.goglin@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Keith Busch <keith.busch@intel.com>, <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tao Xu <tao3.xu@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V6 7/7] docs: mm: numaperf.rst Add brief description for
 access class 1.
Message-ID: <20191218143725.00002f6f@Huawei.com>
In-Reply-To: <4cf4e790-cacb-b250-bf28-5ba540eb0dc7@gmail.com>
References: <20191216153809.105463-1-Jonathan.Cameron@huawei.com>
        <20191216153809.105463-8-Jonathan.Cameron@huawei.com>
        <4cf4e790-cacb-b250-bf28-5ba540eb0dc7@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 18 Dec 2019 12:34:34 +0100
Brice Goglin <brice.goglin@gmail.com> wrote:

> Le 16/12/2019 à 16:38, Jonathan Cameron a écrit :
> > Try to make minimal changes to the document which already describes
> > access class 0 in a generic fashion (including IO initiatiors that
> > are not CPUs).
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  Documentation/admin-guide/mm/numaperf.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
> > index a80c3c37226e..327c0d72692d 100644
> > --- a/Documentation/admin-guide/mm/numaperf.rst
> > +++ b/Documentation/admin-guide/mm/numaperf.rst
> > @@ -56,6 +56,11 @@ nodes' access characteristics share the same performance relative to other
> >  linked initiator nodes. Each target within an initiator's access class,
> >  though, do not necessarily perform the same as each other.
> >  
> > +The access class "1" is used to allow differentiation between initiators
> > +that are CPUs and hence suitable for generic task scheduling, and
> > +IO initiators such as GPUs and CPUs.  Unlike access class 0, only
> > +nodes containing CPUs are considered.
> > +
> >  ================
> >  NUMA Performance
> >  ================
> > @@ -88,6 +93,9 @@ The latency attributes are provided in nanoseconds.
> >  The values reported here correspond to the rated latency and bandwidth
> >  for the platform.
> >  
> > +Access class 0, takes the same form, but only includes values for CPU to
> > +memory activity.  
> 
> 
> Shouldn't this be "class 1" here?
> 
Good point.

Jonathan

> Both hunks look contradictory to me.
> 
> Brice
> 
> 


