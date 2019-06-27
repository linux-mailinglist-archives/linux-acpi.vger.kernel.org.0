Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55A582A7
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfF0Mdx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 08:33:53 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6492 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbfF0Mdx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jun 2019 08:33:53 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RCTRkV002115;
        Thu, 27 Jun 2019 07:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=FCeiWNpqHXKcvbELMFxb5outzLNg2XZ0Ix2/exfdLRw=;
 b=BX4jKeIW93Mw3s5aFaF8AwrDjnKlDxnKY6BdHcCk1zoEAD0l3l818FDSsoFZuklJgWFs
 2cr3USu0leYcfbB6soIEz4oVOo/tv43t0IV0Z3GccG5JbnpmsmjHX0Sa6kmKvBFTEodc
 TDhvlhtnEAkRT4N6/k+fPxDQWvdjEcghEYVifgdNsk5h6I+PpQ2HzHJWrQ2bCiBJOHX8
 fIXY0gUwafY0ovTmdP0Rd7LNdPGCy8LXOT3zbrUSzU4hENrraZkHo98EigmJZKN1rHYg
 NT8VNyggI6Lbbuh3d1YylIXuTIKsGtddm/txSNxj7S2EZmGRmoYN3r/vNl06cmJNVJ6N NA== 
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2tc7gt9whn-1;
        Thu, 27 Jun 2019 07:33:44 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail2.cirrus.com (Postfix) with ESMTP id 7201E605A6B4;
        Thu, 27 Jun 2019 07:33:44 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 27 Jun
 2019 13:33:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 27 Jun 2019 13:33:43 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C66F145;
        Thu, 27 Jun 2019 13:33:43 +0100 (BST)
Date:   Thu, 27 Jun 2019 13:33:43 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] device property: Add new array helper
Message-ID: <20190627123343.GH54126@ediswmail.ad.cirrus.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
 <CAJZ5v0hvN=8YmF+v6wKx9mQ=DRosAtK7QU=EWYf5PXEDsn4FEQ@mail.gmail.com>
 <20190627102345.GG54126@ediswmail.ad.cirrus.com>
 <CAJZ5v0hmMW-3UvvJch+NuYgQ+0iGP-LMrxP8p9wkmaGm1zAQoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hmMW-3UvvJch+NuYgQ+0iGP-LMrxP8p9wkmaGm1zAQoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270147
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 27, 2019 at 01:02:32PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 27, 2019 at 12:23 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Thu, Jun 27, 2019 at 11:39:10AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 26, 2019 at 5:36 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > That is fine, I don't have any problem with the helper living
> > within our driver instead. Basically the issue from my side is I
> > need to read 6 different device tree properties all of which
> > require this behaviour, ie. read a variable number of fixed
> > groups and check I have whole groups. Open coding this for each
> > call is indeed only going to be 5-10 lines of code
> 
> Exactly two:
> 
> n = device_property_count_u32(dev, name);
> ret = device_property_read_u32_array(dev, propname, val, n > nval ? nval : n);
> 
> And I would be fine with adding wrappers like this (and for the other
> data types too for that matter).
> 
> It would take more lines if you wanted to complain about the format,
> but as pointed out above, that would need to be done in the caller
> anyway.
> 

Ok I think that helps me to follow the situation. If
device_property_count cuts down the code required and leaves the
majority of the code as printing the messages which then wants to
live in the end driver anyways it probably isn't worth adding a
core helper for this.

Thank you for the review and the explanation. I will update the
driver patches to use the new function and resend those.

Thanks,
Charles

> > for each one  but since there are 6 of them it makes sense to put those 5-10
> > lines into a helper and have 5-10 lines not 30-60 lines. Seemed
> > the helper might be generally more useful, but if it is not then
> > it can go back into the driver.
