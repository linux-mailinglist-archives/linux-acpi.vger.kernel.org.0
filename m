Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8944B047
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 16:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhKIP0n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 10:26:43 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19319 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234526AbhKIP0n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Nov 2021 10:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636471437; x=1668007437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LhDgqmajfz71vOYSGsDh9gMUO7ALBdgAMuleFHkhVRE=;
  b=TeIK4K0JTNorUsiwPwZwoAGRBmLiCwdqXarvIL6/lsKSeslP7i+DSAm5
   FOpobIxpW3HemsPqXFd6M7MefewILap3b5pE8Y30QDoDGN810AjLwO9nR
   ygfAIzZEDO5j876yfLrrtkX+kXNI2C4Z/+KDv0G2y2Y4wsBI57byusRwT
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Nov 2021 07:23:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 07:23:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 9 Nov 2021 07:23:56 -0800
Received: from qian-HP-Z2-SFF-G5-Workstation (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 9 Nov 2021 07:23:55 -0800
Date:   Tue, 9 Nov 2021 10:23:52 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
Message-ID: <YYqSiMwfdYPwQb62@qian-HP-Z2-SFF-G5-Workstation>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
 <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
 <1269258d-db4c-3922-776b-f11e6a1e338e@quicinc.com>
 <YYlnIpGEmLH5GXft@smile.fi.intel.com>
 <YYn8hpxxmAtw9z5S@qian-HP-Z2-SFF-G5-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YYn8hpxxmAtw9z5S@qian-HP-Z2-SFF-G5-Workstation>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 08, 2021 at 11:43:54PM -0500, Qian Cai wrote:
> Then, which functions do you suggest to replace with
> fwnode_create_software_node()? In dwc3_host_init(),
> 
> int dwc3_host_init(struct dwc3 *dwc)
> {
> 	...
> 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> 	...
> 	ret = platform_device_add(xhci);
> 
> I am wondering if that we could solve the problem by avoiding
> "xhci-hcd" string here which would unfortunately clash with
> xhci_plat_init() as mentioned before:

Okay, I suppose that name has to be "xhci-hcd" to match the dirver
name. Otherwise, the below path did not run to create "xhci-hcd"
either. I noticed that the regression was discussed a few months ago
and leave it as is.

https://lore.kernel.org/lkml/e9bc1397-99b7-a57e-4860-80d146848e2c@nxp.com/

Alternatively, we might revert the commit 434b73e61cc6
("iommu/arm-smmu-v3: Use device properties for pasid-num-bits")
started to use device_add_properties() in iort_named_component_init()
which probably does not look pretty either. I can't think of any other
ways to avoid refactoring at the moment.

> 
>   sysfs_create_link
>   software_node_notify
>   device_create_managed_software_node
>   iort_named_component_init
>   iort_iommu_configure_id
>   acpi_dma_configure_id
>   platform_dma_configure
>   really_probe.part.0
>   really_probe
>   __driver_probe_device
>   driver_probe_device
>   __driver_attach
>   bus_for_each_dev
>   driver_attach
>   bus_add_driver
>   driver_register
>   __platform_driver_register
>   xhci_plat_init
>   do_one_initcall
>   kernel_init_freeable
>   kernel_init
>   ret_from_fork

