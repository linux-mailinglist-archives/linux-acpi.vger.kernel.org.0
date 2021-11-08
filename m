Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E615B449917
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 17:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhKHQKl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 11:10:41 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:24193 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240140AbhKHQKl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2021 11:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636387676; x=1667923676;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DVuLfO6N4imwUeGijPHuCU7f9N/it0Vl247/FSitkDY=;
  b=YJaSyWdygVZ+djmS9VUsrNmGFpt7akyXu3/Dy1TE0y5jC/6vc3r9CeAQ
   jBXQ7IJyYZzqW/jmr9JVZ8+5A2XC6MVva+Bz96e/w7sXEhcZoXNFCi6iw
   hiBVzGdV5LUbgGfvXZyPvm6kYYYdZlqrKNFOp+AaXtc2dDjH9dmRC+/kk
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Nov 2021 08:07:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 08:07:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 8 Nov 2021 08:07:55 -0800
Received: from [10.110.100.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 8 Nov 2021
 08:07:54 -0800
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
 <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <1269258d-db4c-3922-776b-f11e6a1e338e@quicinc.com>
Date:   Mon, 8 Nov 2021 11:07:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 11/5/21 3:39 PM, Andy Shevchenko wrote:
>> Andy, thanks for the pointers so far. I was able to trace
>> set_primary_fwnode() and set_secondary_fwnode().
> 
> Can you share the trace you have got?


I used a simple debugging patch below:

diff --git a/drivers/base/core.c b/drivers/base/core.c

index fd034d742447..d8ae96289acf 100644

--- a/drivers/base/core.c

+++ b/drivers/base/core.c

@@ -4742,6 +4742,11 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)

 	struct device *parent = dev->parent;

 	struct fwnode_handle *fn = dev->fwnode;

 

+	printk("KK set_primary_fwnode dev name = %s, fwnode = %px\n", dev_name(dev), fwnode);

+	if (parent)

+		printk("KK parent = %s\n", dev_name(dev->parent));

+	if (fwnode && fwnode->dev)

+		printk("KK fwnode->dev = %s\n", dev_name(fwnode->dev));

 	if (fwnode) {

 		if (fwnode_is_primary(fn))

 			fn = fn->secondary;

@@ -4761,6 +4766,8 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)

 			dev->fwnode = NULL;

 		}

 	}

+	if (fwnode)

+		printk("KK secondary = %px\n", dev->fwnode->secondary);

 }

 EXPORT_SYMBOL_GPL(set_primary_fwnode);

 

@@ -4775,13 +4782,20 @@ EXPORT_SYMBOL_GPL(set_primary_fwnode);

  */

 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)

 {

+	printk("KK set_secondary_fwnode dev name = %s, fwnode = %px\n", dev_name(dev), fwnode);

+	if (dev->parent)

+		printk("KK parent = %s\n", dev_name(dev->parent));

+	if (fwnode && fwnode->dev)

+		printk("KK fwnode->dev = %s\n", dev_name(fwnode->dev));

 	if (fwnode)

 		fwnode->secondary = ERR_PTR(-ENODEV);

 

-	if (fwnode_is_primary(dev->fwnode))

+	if (fwnode_is_primary(dev->fwnode)) {

 		dev->fwnode->secondary = fwnode;

-	else

+		printk("KK primary = %px\n", dev->fwnode);

+	} else {

 		dev->fwnode = fwnode;

+	}

 }

 EXPORT_SYMBOL_GPL(set_secondary_fwnode);

 
Then, here are the relevant outputs indicating that
"808622B7:01" and  "xhci-hcd.3.auto" have the same
primary but different secondaries.

[   11.233280] KK set_secondary_fwnode dev name = 808622B7:01, fwnode = ffff000838618840

[   11.241846] KK parent = platform

[   11.245790] KK primary = ffff0008064b9010

[   11.259838] KK set_primary_fwnode dev name = (null), fwnode = ffff0008064b9010

[   11.267795] KK parent = 808622B7:01

[   11.272000] KK fwnode->dev = 808622B7:01

[   11.276636] KK secondary = ffff000838618840

[   11.680489] KK set_secondary_fwnode dev name = xhci-hcd.3.auto, fwnode = ffff000838325040

[   11.689406] KK parent = 808622B7:01

[   11.693916] KK primary = ffff0008064b9010
[   11.698763] sysfs: cannot create duplicate filename '/devices/platform/808622B7:01/xhci-hcd.3.auto/software_node'
