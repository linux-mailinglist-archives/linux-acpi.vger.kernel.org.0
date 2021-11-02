Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4E443026
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 15:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhKBOUV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 10:20:21 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:51966 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhKBOUU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 10:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635862665; x=1667398665;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RPgoEHvTBU8KNlt3EetYBZuJAehLk4kT7pCMgjtE7cU=;
  b=C3WAG7rw/WL7ZC05VZ4rNc9vYoKtD2/p/6RG/w6NxTsnuOOJQ4gMJbR2
   O73q0FqscAlLxuQDD+zhz5II5h3s9e6RBA8PYCylUVQh0AJsC17mt5qlW
   2smU2B/44JEFGagO1gshEHY33RGErAPI0Ld6ACLt59UdVU0U01UJl+7ph
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Nov 2021 07:17:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 07:17:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 2 Nov 2021 07:17:44 -0700
Received: from [10.110.22.220] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 2 Nov 2021
 07:17:42 -0700
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <YYD2uXPcnFmiy54c@kuha.fi.intel.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <ade40ab7-b482-5b38-60dd-7bd5f697e8bc@quicinc.com>
Date:   Tue, 2 Nov 2021 10:17:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYD2uXPcnFmiy54c@kuha.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 11/2/21 4:28 AM, Heikki Krogerus wrote:
> I'm actually not sure what is going on in this case, because this is
> the ACPI enumerated BSW board, at least based on the ACPI ID?

Yes, this is an ACPI-based server.

> That board should not have the initial secondary fwnode assigned by
> the time the dwc3 host driver is called.

Heikki, what information would be helpful to figure it out? Is the full
demsg useful here?
