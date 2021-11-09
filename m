Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4644A5DE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 05:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbhKIEqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 23:46:40 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:62176 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242766AbhKIEqk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2021 23:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636433035; x=1667969035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPvJcJDPMdp7Swo0W51sy6DYmybCviFK4B196uJ5MtU=;
  b=B4RJTFsVYUWnpLsLCLV9YTjlCqdSfTmFSJm7ZcxYJXKZ68rP+RA4lHZh
   CIf2R60odjISVa7YAyXXTQFRCvMOOPxaTsGNlJASAODykVdjUwhr9oXWc
   BFF3wctjiZpp5h1BqDX6c+dzwq6Q2bDNAjtejuCycOXIv/UpTONMH4CU9
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Nov 2021 20:43:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 20:43:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 8 Nov 2021 20:43:54 -0800
Received: from qian-HP-Z2-SFF-G5-Workstation (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 8 Nov 2021 20:43:52 -0800
Date:   Mon, 8 Nov 2021 23:43:50 -0500
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
Message-ID: <YYn8hpxxmAtw9z5S@qian-HP-Z2-SFF-G5-Workstation>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
 <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
 <1269258d-db4c-3922-776b-f11e6a1e338e@quicinc.com>
 <YYlnIpGEmLH5GXft@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YYlnIpGEmLH5GXft@smile.fi.intel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 08, 2021 at 08:06:26PM +0200, Andy Shevchenko wrote:
> Btw, what you can do in this case is to switch to use fwnode_create_software
> node and switch them in drd.c. It will be much much easier to achieve then
> full kernel refactoring.

(Adding arm64 and dwc3 people since that iort_iommu_configure_id()
path below to create a duplicated sysfs is arm64-specific. The
original thread is here):

https://lore.kernel.org/lkml/20211101200346.16466-1-quic_qiancai@quicinc.com/

Andy, did you mean host.c? I saw that the first time
"/devices/platform/808622B7:01/xhci-hcd.3.auto/software_node" was
created by dwc3_host_init(). Call trace:

  sysfs_do_create_link_sd.isra.0
  sysfs_create_link
  software_node_notify
  device_add
  platform_device_add
  dwc3_host_init
  dwc3_probe
  platform_probe
  really_probe.part.0
  really_probe
  __driver_probe_device
  driver_probe_device
  __driver_attach
  bus_for_each_dev
  driver_attach
  bus_add_driver
  driver_register
  __platform_driver_register
  dwc3_driver_init
  dwc3_driver_init at drivers/usb/dwc3/core.c:2072
  do_one_initcall
  kernel_init_freeable
  kernel_init
  ret_from_fork

Then, which functions do you suggest to replace with
fwnode_create_software_node()? In dwc3_host_init(),

int dwc3_host_init(struct dwc3 *dwc)
{
	...
	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
	...
	ret = platform_device_add(xhci);

I am wondering if that we could solve the problem by avoiding
"xhci-hcd" string here which would unfortunately clash with
xhci_plat_init() as mentioned before:

  sysfs_create_link
  software_node_notify
  device_create_managed_software_node
  iort_named_component_init
  iort_iommu_configure_id
  acpi_dma_configure_id
  platform_dma_configure
  really_probe.part.0
  really_probe
  __driver_probe_device
  driver_probe_device
  __driver_attach
  bus_for_each_dev
  driver_attach
  bus_add_driver
  driver_register
  __platform_driver_register
  xhci_plat_init
  do_one_initcall
  kernel_init_freeable
  kernel_init
  ret_from_fork

since the driver would also use "xhci-hcd".

static struct platform_driver usb_xhci_driver = {
	...
	.driver	= {
		.name = "xhci-hcd",

static int __init xhci_plat_init(void)
{
       ...
       return platform_driver_register(&usb_xhci_driver);


BTW, "/sys/devices/platform/808622B7:01/software_node" was also
created from the path:

  sysfs_create_link
  software_node_notify
  device_create_managed_software_node
  iort_named_component_init
  iort_iommu_configure_id
  acpi_dma_configure_id
  platform_dma_configure
  really_probe.part.0
  really_probe
  __driver_probe_device
  driver_probe_device
  __driver_attach
  bus_for_each_dev
  driver_attach
  bus_add_driver
  driver_register
  __platform_driver_register
  dwc3_driver_init
  do_one_initcall
  kernel_init_freeable
  kernel_init
  ret_from_fork

# ls -l /sys//devices/platform/808622B7:01/xhci-hcd.3.auto/software_node
lrwxrwxrwx 1 root root 0 Nov  9 03:18 /sys//devices/platform/808622B7:01/xhci-hcd.3.auto/software_node -> ../../../../kernel/software_nodes/node4

# ls -l /sys//devices/platform/808622B7:01/software_node
lrwxrwxrwx 1 root root 0 Nov  9 03:18 /sys//devices/platform/808622B7:01/software_node -> ../../../kernel/software_nodes/node4
