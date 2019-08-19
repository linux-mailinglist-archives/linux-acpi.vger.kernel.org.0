Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD85094CA2
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfHSSWb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 14:22:31 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:54756 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728194AbfHSSWb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 14:22:31 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JI5TXN011062;
        Mon, 19 Aug 2019 14:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=C9FVKd3NlySfbqFbF4GHfxeE1q6YW8vF8n7vWCTD/d4=;
 b=wYrvjr3RxA13jy0NKN8KgNh5Xs4zzvYRf1do34Ef9HxnksxDIYrNu8SgyR2O/006IRVL
 hqykhUE42i6fereAAa+w9YnBTPWmIWqkye65ozfdhd66VU+gwkqF2nrKe3pkVxeD98TU
 Dir/qiuz/vOtt3DPMyaCgCJ7vXe/7tovYT7Ytc4qbK5DbBmmItU16hKJ0NQnRkiNwxPX
 ILcNyVIsWcpFtPYC6G5vCC2zmleA6pD+DjG+jyzHDcJTTN8Fb11NLtIl8wxq/8UqToed
 llAa6lgAKEhuGcl6RdU8b8hIP/sdrRelHKhsBwmQrGuHUTRH2vCPecMqHJeaBQKAytiE pw== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2uecn40147-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 14:22:30 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JI8VVX072310;
        Mon, 19 Aug 2019 14:22:29 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2ufyuvs20x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 14:22:29 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1346477162"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <lukas@wunner.de>,
        <anthony.wong@canonical.com>, <rajmohan.mani@intel.com>,
        <raanan.avargil@intel.com>, <David.Laight@aculab.com>,
        <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Thread-Topic: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Thread-Index: AQHVVoBozBrF8LXinkuY9L30yxdXE6cCqCcggABtzQD//7HyEA==
Date:   Mon, 19 Aug 2019 18:22:26 +0000
Message-ID: <c56451e3ae244acd8a824fbca1322c0c@AUSX13MPC101.AMER.DELL.COM>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
 <5486107424db48f2a06ed4c8a81f75b0@AUSX13MPC101.AMER.DELL.COM>
 <20190819175730.GX19908@lahna.fi.intel.com>
In-Reply-To: <20190819175730.GX19908@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-19T18:20:28.5422271Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190191
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190191
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> > I've tested this on a pre-production ICL platform.  This was on top of =
5.3-rc5,
> both of
> > your patches from -next and this series.
> >
> > I've run into a problem when using
> > a WD19TB that after unplugging it will cause the following to spew in d=
mesg:
> >
> > [ 2198.017003] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [ 2198.017005] WARNING: possible recursive locking detected
> > [ 2198.017008] 5.3.0-rc5+ #75 Not tainted
> > [ 2198.017009] --------------------------------------------
> > [ 2198.017012] irq/122-pciehp/121 is trying to acquire lock:
> > [ 2198.017015] 00000000801d4de8 (&ctrl->reset_lock){.+.+}, at:
> pciehp_check_presence+0x1b/0x80
> > [ 2198.017026]
> >                but task is already holding lock:
> > [ 2198.017028] 000000000899e2eb (&ctrl->reset_lock){.+.+}, at:
> pciehp_ist+0xaf/0x1c0
> > [ 2198.017033]
> >                other info that might help us debug this:
> > [ 2198.017035]  Possible unsafe locking scenario:
> >
> > [ 2198.017037]        CPU0
> > [ 2198.017038]        ----
> > [ 2198.017041]   lock(&ctrl->reset_lock);
> > [ 2198.017044]   lock(&ctrl->reset_lock);
> > [ 2198.017046]
> >                 *** DEADLOCK ***
> >
> > [ 2198.017048]  May be due to missing lock nesting notation
> >
> > [ 2198.017051] 3 locks held by irq/122-pciehp/121:
> > [ 2198.017052]  #0: 000000000899e2eb (&ctrl->reset_lock){.+.+}, at:
> pciehp_ist+0xaf/0x1c0
> > [ 2198.017057]  #1: 0000000069e1fd47 (pci_rescan_remove_lock){+.+.}, at=
:
> pciehp_unconfigure_device+0x41/0x130
> > [ 2198.017064]  #2: 0000000046a5bfbf (&dev->mutex){....}, at:
> device_release_driver_internal+0x1c/0x1a0
> > [ 2198.017071]
> >                stack backtrace:
> > [ 2198.017075] CPU: 3 PID: 121 Comm: irq/122-pciehp Not tainted 5.3.0-r=
c5+ #75
> > [ 2198.017079] Call Trace:
> > [ 2198.017089]  dump_stack+0x5e/0x8b
> > [ 2198.017096]  __lock_acquire+0x12fe/0x1520
> > [ 2198.017102]  lock_acquire+0x9d/0x1a0
> > [ 2198.017105]  ? pciehp_check_presence+0x1b/0x80
> > [ 2198.017113]  ? pci_restore_standard_config+0x40/0x40
> > [ 2198.017118]  down_read+0x3b/0x160
> > [ 2198.017121]  ? pciehp_check_presence+0x1b/0x80
> > [ 2198.017123]  pciehp_check_presence+0x1b/0x80
> > [ 2198.017128]  ? quirk_disable_msi.part.29+0x31/0x31
> > [ 2198.017131]  pciehp_resume+0x27/0x30
> > [ 2198.017136]  device_for_each_child+0x47/0x90
> > [ 2198.017140]  ? pci_restore_standard_config+0x40/0x40
> > [ 2198.017145]  pcie_port_device_runtime_resume+0x30/0x50
> > [ 2198.017150]  pci_pm_runtime_resume+0x6e/0xc0
> > [ 2198.017156]  __rpm_callback+0xb0/0x110
> > [ 2198.017161]  ? pci_restore_standard_config+0x40/0x40
> > [ 2198.017165]  rpm_callback+0x1f/0x70
> > [ 2198.017169]  ? pci_restore_standard_config+0x40/0x40
> > [ 2198.017173]  rpm_resume+0x4fe/0x690
> > [ 2198.017179]  ? irq_forced_thread_fn+0x70/0x70
> > [ 2198.017183]  __pm_runtime_resume+0x47/0x80
> > [ 2198.017187]  device_release_driver_internal+0x7c/0x1a0
> > [ 2198.017191]  pci_stop_bus_device+0x5d/0x80
> > [ 2198.017195]  pci_stop_bus_device+0x2b/0x80
> > [ 2198.017198]  pci_stop_and_remove_bus_device+0xe/0x20
> > [ 2198.017202]  pciehp_unconfigure_device+0x7c/0x130
> > [ 2198.017206]  pciehp_disable_slot+0x69/0x120
> > [ 2198.017211]  pciehp_handle_presence_or_link_change+0x7d/0x4b0
> > [ 2198.017215]  pciehp_ist+0x12a/0x1c0
> > [ 2198.017219]  irq_thread_fn+0x1b/0x60
> > [ 2198.017222]  irq_thread+0x15b/0x1c0
> > [ 2198.017226]  ? lockdep_hardirqs_on+0x115/0x180
> > [ 2198.017229]  ? wake_threads_waitq+0x30/0x30
> > [ 2198.017233]  ? irq_thread_dtor+0x90/0x90
> > [ 2198.017237]  kthread+0x101/0x140
> > [ 2198.017241]  ? kthread_cancel_delayed_work_sync+0x10/0x10
> > [ 2198.017245]  ret_from_fork+0x24/0x30
> > [ 2198.017897] xhci_hcd 0000:03:00.0: remove, state 1
> > [ 2198.017917] usb usb6: USB disconnect, device number 1
> > [ 2198.017925] usb 6-2: USB disconnect, device number 2
> > [ 2198.017932] usb 6-2.3: USB disconnect, device number 3
> > [ 2198.017939] usb 6-2.3.1: USB disconnect, device number 5
> > [ 2198.019565] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > [ 2198.019671] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result:
> hostbyte=3DDID_NO_CONNECT driverbyte=3DDRIVER_OK
> > [ 2198.057200] xhci_hcd 0000:03:00.0: xHCI host controller not respondi=
ng,
> assume dead
> > [ 2198.057227] r8152 6-2.4:1.0 enxd8d090034dcb: Stop submitting intr, s=
tatus -
> 108
> > [ 2198.057574] usb 6-2.4: USB disconnect, device number 4
> > [ 2198.074541] xhci_hcd 0000:03:00.0: USB bus 6 deregistered
> > [ 2198.074558] xhci_hcd 0000:03:00.0: remove, state 1
> > [ 2198.074564] usb usb5: USB disconnect, device number 1
> > [ 2198.074566] usb 5-2: USB disconnect, device number 2
> > [ 2198.074569] usb 5-2.3: USB disconnect, device number 3
> > [ 2198.074571] usb 5-2.3.4: USB disconnect, device number 5
> > [ 2198.077367] usb 5-2.3.5: USB disconnect, device number 6
> > [ 2198.078488] usb 5-2.5: USB disconnect, device number 4
> > [ 2198.080340] xhci_hcd 0000:03:00.0: Host halt failed, -19
> > [ 2198.080344] xhci_hcd 0000:03:00.0: Host not accessible, reset failed=
.
> > [ 2198.080770] xhci_hcd 0000:03:00.0: USB bus 5 deregistered
> > [ 2198.081153] pci 0000:03:00.0: Removing from iommu group 3
> > [ 2198.081180] pci_bus 0000:03: busn_res: [bus 03] is released
> > [ 2198.081287] pci 0000:02:02.0: Removing from iommu group 3
> > [ 2198.081396] pci_bus 0000:04: busn_res: [bus 04-2d] is released
> > [ 2198.081509] pci 0000:02:04.0: Removing from iommu group 3
> > [ 2198.082273] pci_bus 0000:02: busn_res: [bus 02-2d] is released
> > [ 2198.085759] pci 0000:01:00.0: Removing from iommu group 3
> > [ 2198.630098] thunderbolt 0-1: device disconnected
> >
> > Additionally I've found after this I can't get the dock to work by hotp=
lugging
> again
> > until I reboot the system.
>=20
> Can you try if the following patch helps?
>=20
> https://lore.kernel.org/patchwork/patch/1113961/

I just checked with that patch on top of my previous test kernel, same call=
 trace
situation.
