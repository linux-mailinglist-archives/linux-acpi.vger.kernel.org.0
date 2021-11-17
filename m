Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED0D454ACA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 17:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhKQQVf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 11:21:35 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:64179 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231442AbhKQQVe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 11:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637165916; x=1668701916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AQ5sge1TrMoWNuFXk3p6igjJRdS6hNebzYU0VeQUJeI=;
  b=AI+IdSB9RdL5V7eTy/JEFNKzugq1ahLH0LhqCxca+S3jfJAfs1XYJHJz
   Y9kxYCHxBQqI6zLbxNtZpmo6Q6QtDC1f+Uy+g7YhOr/4tZ3Sbk3bfBXzG
   IExnoR6svOK4XvtRzfu1Ma5cL2yx5sG8TaNKT8HPJGqywu7c8pOuQgDEt
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Nov 2021 08:18:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 08:18:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 17 Nov 2021 08:18:35 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 17 Nov
 2021 08:18:34 -0800
Date:   Wed, 17 Nov 2021 11:18:29 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
Message-ID: <YZUrVdcI9nzTUJfn@quicinc.com>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
 <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
 <YZMrjqhYYNGMP84x@qian-HP-Z2-SFF-G5-Workstation>
 <CAJZ5v0hjq+X=Gej072jwY2Uf4BgvqPHvHTON2p0Mszd5ntjjJA@mail.gmail.com>
 <YZUT5EPqPiPy2iiy@fixkernel.fios-router.home>
 <CAJZ5v0if7__bYSnNWYNd7c9MfG32Sm2_cRcw6Qr+C2t2ywE-tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0if7__bYSnNWYNd7c9MfG32Sm2_cRcw6Qr+C2t2ywE-tg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 17, 2021 at 03:45:34PM +0100, Rafael J. Wysocki wrote:
> > since we will no longer has a dev->fwnode pointer anymore. Do you
> > suggest to keep that pointer but convert the "secondary" to a linked
> > list instead?
> 
> Yes, please.

Sounds good. I think that would simplify the changes of the existing
interfaces even though only to mantain one fwnode_head would be a bit
cleaner. Though, that cleanup could always be on top later if needed.
