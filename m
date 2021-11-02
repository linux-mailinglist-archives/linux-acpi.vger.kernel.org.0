Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA644369A
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKBTrT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 15:47:19 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:10664 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBTrS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 15:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635882284; x=1667418284;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wf+If0x65Yy+o0SSEO3jAsZ2Konv0lsU7aUjVHqEeo4=;
  b=vjaS8vm675Il9AuGTIVgdSUGRVUsjEQvD8cQ0xIr86WlkFOw2nu4PkPE
   TZuiy5KNFLF5T6MaDF9c8ukf29XpP5kXHqWPJRMleazDuzEP1iltBe7Jm
   ocH/Oj2+tkNTRYO+5Y7MIXW7bdLcxbT8icpE08aaKvkOvrWRPSaXfEme6
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Nov 2021 12:44:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 12:44:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 2 Nov 2021 12:44:42 -0700
Received: from [10.110.22.220] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 2 Nov 2021
 12:44:41 -0700
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
Message-ID: <c5767824-f39c-772c-d376-77db24bb2f84@quicinc.com>
Date:   Tue, 2 Nov 2021 15:44:40 -0400
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

Andy, this is my first time touching fwnode/swnode. After reading the
source code for a few hours, I still don't understand the hint here.
Specifically, what does the "the link" refer to?
