Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5B44689E
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 19:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhKESu1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 14:50:27 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:47975 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKESu1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 14:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636138067; x=1667674067;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=G3qfrI/sS+kNFHo6v7HTnTcHlMqBxMKZpKZwQGGOccM=;
  b=mV/rhr0e9CAhZFT84k3qsazA73itdbKDeVpTbAGXUf8Wwt1nuFAcodxm
   SLXNiBIefRrCTBElOrhVmS8hGY4Aa3LfUrIVXv908kTfmDAvYo4zNzNCe
   9m8l+sTDcTAdyD0QpJj7NwbZUjb1TILnMiVDYL+2e9BE4yWuzcbOFWREk
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Nov 2021 11:47:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 11:47:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 11:47:46 -0700
Received: from [10.110.96.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Fri, 5 Nov 2021
 11:47:45 -0700
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
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
Date:   Fri, 5 Nov 2021 14:47:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 11/1/21 7:51 PM, Andy Shevchenko wrote:
> No, it’s not so easy. What you are doing is a papering over the real issue
> which is the limitation of the firmware nodes to two. What we need is to
> drop the link from struct fwnode_handle, move it to upper layer and modify
> all fwnode ops to be used over the list of fwnode:s.
> 
> XHCI driver and DWC3 are sharing the primary fwnode, but at the same time
> they wanted to have _different_ secondary ones when role is switched. This
> can’t be done in the current design. And here is the symptom what you got.

Andy, thanks for the pointers so far. I was able to trace
set_primary_fwnode() and set_secondary_fwnode().

Anyway, what's the "upper layer"? Is that "struct device" or "struct
swnode"? I suppose you meant:

- Remove "secondary" field from "struct fwnode_handle".
- Replace "fwnode" from "upper layer" with
  "struct list_head fwnode_head;".
- Modify all functions in "software_node_ops" to use "fwnode_head".

Is that correct?
