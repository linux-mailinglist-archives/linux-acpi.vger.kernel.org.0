Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2038358024
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0KX4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 06:23:56 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33616 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbfF0KX4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jun 2019 06:23:56 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RAEd0O016069;
        Thu, 27 Jun 2019 05:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/SLbXZX6AA9C3wW/Ho9qCV4/4q0Ztya7LGeYh/278XY=;
 b=JqyMctuVjCGHFHl64x+dZNe66l/9dW0RGadWfeeyp7LHQ8MlpKmjopPnGW2QY05k4qMg
 LyICL60PsEIh8NnsT7biQ77kq9/pdEmiDxtdHsE4LTNcrms9+firwghwF3S5pgPGDLH9
 FPH1CcgHwjUQSBrYpjFbk8T+xu8yvbcmx+EpOx/lTEUA9bj1jebAjDS4x/2iJG9mY4cH
 FyTfV/jHNLYgEUhhsEjKy+SYzNe628E7HP28wEW2Z5otsGUUl5QwE/HfR+gzWEKjn+Oo
 h7Cu1zs46lJ1P9QoV5/7nxpa7LWVirwJLj947Hnu8CkluNrlmW6IK8pHFdcPQ5qBQ/4c tw== 
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2t9hr2gtsm-1;
        Thu, 27 Jun 2019 05:23:46 -0500
Received: from EDIEX01.ad.cirrus.com (unknown [198.61.84.80])
        by mail1.cirrus.com (Postfix) with ESMTP id 3034F611C8B2;
        Thu, 27 Jun 2019 05:23:46 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 27 Jun
 2019 11:23:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 27 Jun 2019 11:23:45 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 860DF2A1;
        Thu, 27 Jun 2019 11:23:45 +0100 (BST)
Date:   Thu, 27 Jun 2019 11:23:45 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] device property: Add new array helper
Message-ID: <20190627102345.GG54126@ediswmail.ad.cirrus.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
 <CAJZ5v0hvN=8YmF+v6wKx9mQ=DRosAtK7QU=EWYf5PXEDsn4FEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hvN=8YmF+v6wKx9mQ=DRosAtK7QU=EWYf5PXEDsn4FEQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270120
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 27, 2019 at 11:39:10AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 26, 2019 at 5:36 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > +       n = device_property_read_u32_array(dev, propname, NULL, 0);
> > +       if (n == -EINVAL) {
> > +               return 0;       /* missing, ignore */
> 
> Why can't the caller use the (scheduled for merging in the 5.3 cycle)
> new device_property_count_u32() to get the size of the array?
> 

I wasn't aware of it, am now.

> > +       } else if (n < 0) {
> > +               dev_warn(dev, "%s malformed (%d)\n", propname, n);
> 
> Why dev_warn()?  Is there any reason real for anything higher-level
> that dev_dbg() here?
> 

Nice to know that your DT wasn't valid, but could be left to the
caller I guess.

> > +               return n;
> > +       } else if ((n % multiple) != 0) {
> 
> I guess the reason why this matters is that the caller expects a
> certain number of full "rows" and n values are read.  Why not to
> discard the extra values instead of returning an error here?
>

No reason really why it couldn't. Although my expectation would
generally be this helper is for reading a variable number of
fixed size groups. As in each group represents a "whole" item but
you don't know how many of those you have.

> > +               dev_warn(dev, "%s not a multiple of %d entries\n",
> > +                        propname, multiple);
> > +               return -EOVERFLOW;
> 
> Why this error code?
> 

As that is the error code all the device_property functions
return when the size is not as expected.

> > +       if (n > nval)
> > +               n = nval;
> > +
> > +       ret = device_property_read_u32_array(dev, propname, val, n);
> 
> So this reads "copy at most nval values from the array property".
> 
> If that's really what you need, it can be done in two lines of code in
> prospective callers of this wrapper.
> 

Indeed the helper here is basically exactly what would be done in
the caller if no helper existed.

> > +int device_property_read_u32_2darray(struct device *dev, const char *propname,
> > +                                    u32 *val, size_t nval, int multiple);
> >  int device_property_read_u64_array(struct device *dev, const char *propname,
> >                                    u64 *val, size_t nval);
> >  int device_property_read_string_array(struct device *dev, const char *propname,
> > --
> 
> I don't see much value in this change, sorry.

That is fine, I don't have any problem with the helper living
within our driver instead. Basically the issue from my side is I
need to read 6 different device tree properties all of which
require this behaviour, ie. read a variable number of fixed
groups and check I have whole groups. Open coding this for each
call is indeed only going to be 5-10 lines of code for each one
but since there are 6 of them it makes sense to put those 5-10
lines into a helper and have 5-10 lines not 30-60 lines. Seemed
the helper might be generally more useful, but if it is not then
it can go back into the driver.

Thanks,
Charles
