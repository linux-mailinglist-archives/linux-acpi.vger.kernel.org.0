Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8970027D75C
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgI2T41 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 15:56:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:30739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgI2T41 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 15:56:27 -0400
IronPort-SDR: ndVvVOKMaOPEVe0HFqAPSJqfCDj5awIWt6TtOuPH9HBtgI23/muYjKd9yRKoyTXn6ZmUDTPRlY
 I3Iz5W/1yMRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="162338709"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="162338709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 12:56:23 -0700
IronPort-SDR: DrcFSQAIBYAt4q2BfKvHbKPiOpe/Ftj3STx5CdHMxn2fdIi9IjS9S4tCHxG74eOzEx0CYBM7Lh
 m67Kdc8fnJhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="294376862"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2020 12:56:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Sep 2020 12:56:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Sep 2020 12:56:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 29 Sep 2020 12:55:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1Et3OFljOQEBGtnMTFwZR5MoUCYLi7zQxMFqD/7ywq8X5WEbMUUx4PzGV0m23UgHYWh1+W1oDS9z4SI9huPAmCJeXAEwJ//yJgk6wn+y6scWpqdy4+p7HERIN3pipI61nDluxalDBxSXidQVtKUQnEsZQ/KBs0ULfRm/WS3YNxsu/DprGq5lOnJ+dcnXxg5cZZXl2xFO3f0hG5iJ9mMGeiMHzFmNrOT5Q0sGO0HlNSkfrVqubSJwur9fHwSHYcu0tZmLcWO0Bq9N4jU1S5odt5YjNta/be+CQTMiVGd5aZjjW4tIXcN/7b6uu7bsu/KMnl1gBZrwXtCNiLkuCk6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9IKOyQQBZ3g2q0fzKKSA22G+AqRpV8UmNa3lK0ZtmA=;
 b=BQz6bZjTjwt9F4Vr9nN2rBKnJGbTK/n1kEVk/UttBjKsjjJx9XZbuekaJVkJTxo3pxC1AO6+WVP4RImn0rRBqOkf6VcKCeYMcCIv6qmxkL8zZCwvaiEAoB50CqBvGyTsPilCUyjjjl1AHS0G5dWOkPp+009ahrnyMzV3kEWykliXucJ+6DXNCBkqwPR/+iDgqS9qRI0punbq/q2xKa0mBcNfifzeujX9EBNIfOX9+VhOeIXozpYOt15aHv4RCnIIdAipMpgByxvMtQQFFlGWbKrFoLF/iktBJU0OW6bFmPITBrxBXN3kNJazIwib3rhTq9Yz/bAHkgTYoE9+fgpwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9IKOyQQBZ3g2q0fzKKSA22G+AqRpV8UmNa3lK0ZtmA=;
 b=bVCIuSce+aiyFpUC6RpwsPgbTj0u1rMEEXCBa/FJCK7ayTPAz8OugeH8pp03U1rnIRVf0NBzc4Ma2jftfaZzSUb75Ypvf5c/AhgrYVZE+YrNPM63x/ZqDC/JUOvU1Rk3Q87ND0aFdUBLLlut7vzUC2nzL99NIyqr3JBzum3BDfw=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR1101MB2285.namprd11.prod.outlook.com (2603:10b6:301:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 19:55:32 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4c08:c078:72e5:a036]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4c08:c078:72e5:a036%8]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 19:55:32 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Qian Cai <cai@redhat.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: RE: [PATCH] ACPICA: Fix a soft-lockup on large systems
Thread-Topic: [PATCH] ACPICA: Fix a soft-lockup on large systems
Thread-Index: AQHWlo9DGClZaMnv7EyD7W4PoYAUL6l/9gfg
Date:   Tue, 29 Sep 2020 19:55:32 +0000
Message-ID: <MWHPR11MB1599F021CB3EBADF44562D5CF0320@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20200929183444.25079-1-cai@redhat.com>
In-Reply-To: <20200929183444.25079-1-cai@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.103.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6ab996b-7838-413b-6bd5-08d864b19faa
x-ms-traffictypediagnostic: MWHPR1101MB2285:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2285544AE089FDD57B469872F0320@MWHPR1101MB2285.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7IkkFd2/G09KukgL86LnSHp/d8drlY/IZUK+woz0oCc3WFtA43FXuWImkyjNM4mKKVpXg7iELlHDTXFQkbNDFxmYflb5N9lBnZTzAa6/e9+7OSnqg4MquDccUcRCzlsjIQJveAH7ew9XVZVag2V11slsGpCIti94lWeyoDl2/FqAmlSlnTrLXkUrpY1qui55BsvskQLkDk1Gq7fVOYhNdQ75j2m+LulNplDAdubhX22yE7bVvP+Xhra63f0PJBufxiGgZrxG7NR11PmwTRrJnbmmiRgA2ithXu7AXEjlsLc+1yegEppucc3/xak2WeLoR7LX/f7+wptdTc0qE4+5//O06RXsV4UdcpxD2KNp/1/1RDJzjLb5X6i7TxLd/NA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(6506007)(71200400001)(66446008)(64756008)(66556008)(66476007)(83380400001)(52536014)(33656002)(66946007)(76116006)(5660300002)(186003)(55016002)(8676002)(86362001)(6636002)(26005)(53546011)(7696005)(9686003)(54906003)(2906002)(316002)(110136005)(478600001)(8936002)(45080400002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: amynsNFt35VH6o+6cijqqYKLXmXnp+OP/iApQU/yXjtkm3eVNqp6Os1DJpaps57veAvn0E0f+KQ7D4qGLRGh1ivc3TEOkEkG1sf9RpU/BMDp08WNlnVxnXCLfdASMWrz6KMHFZWKBvWzTCh+uGcptdeMjioUZ1VgVfsk9NEhPiLfGNzhYfb/vEjkRZiGDcWikknbYAr3cB8Veu7UQZBmoRkdkorLxOtCf9PTYEzezQxL7LPog0eLwWWfvqnl0JqJYq+KOwsABqVSx/15Kpo0xStaF+CA6hedfLrHSCpV3MeFFUsrnZYBo+iveqWgDHcI/DKFitVo0rKyhswXwgm51xtzTNzdrrenGMl69FnAiyw104KHCyUkRfXVYcrEPGIHUvqo47mIJGP5d9T7FzM+peb5ydMAxDq//91kVBSFDIYIGvnHz/JI0ZOnxYgxWX5/A+bWtlkxiST/tE6MmUcf67ayGX8QZHL2CPXhwvO5rSbi0S/QEB0gNP2UuAHZKrD6dtc+DXPSk1ZWc3ScN5gbKhncPfriTGDOKXBf/Txq32Da2It3ohtEDWF30mHWFypKEMNUi3uCTuk+9KqaGBfYTsbrSMauNP7bkfFmAEuRl4ABkxhkqoMT72/S9wtCOwYYb+fUxLXEkYxXYawy1PWhsA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ab996b-7838-413b-6bd5-08d864b19faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 19:55:32.2300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMvdhr5+NpHR/C1hhj3+J3eYHudBtBUYLBsSWGnYJdjFXQtve5ChheL/VsmFK/Bn64MD/m8WTD6EoUE8MuIm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2285
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Qian Cai <cai@redhat.com>
> Sent: Tuesday, September 29, 2020 11:35 AM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org;
> devel@acpica.org; linux-kernel@vger.kernel.org; Paul E. McKenney
> <paulmck@kernel.org>
> Subject: [PATCH] ACPICA: Fix a soft-lockup on large systems
>=20
> It could take a long time in the loop of acpi_ns_walk_namespace() on
> large systems due to there are many nodes in ACPI namespace, and then
> trigger a soft-lockup. Fix it by adding cond_resched() within the loop.
>=20
> [   70.533393] watchdog: BUG: soft lockup - CPU#25 stuck for 22s!
> [swapper/0:1]
> [   70.533438] Modules linked in:
> [   70.533468] irq event stamp: 26257732
> [   70.533489] hardirqs last  enabled at (26257731): [<ffffa000106f2e88>]
> __slab_alloc+0xa8/0xc8
> [   70.533505] hardirqs last disabled at (26257732): [<ffffa0001017387c>]
> el1_irq+0x7c/0x140
> el1_irq at arch/arm64/kernel/entry.S:650
> [   70.533520] softirqs last  enabled at (26197382): [<ffffa00010171a90>]
> efi_header_end+0xa90/0x10bc
> [   70.533535] softirqs last disabled at (26197377): [<ffffa0001024a63c>]
> irq_exit+0x2c4/0x348
> [   70.533551] CPU: 25 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc7-next-
> 20200929 #1
> [   70.533563] Hardware name: HPE Apollo 70             /C01_APACHE_MB   =
      ,
> BIOS L50_5.13_1.15 05/08/2020
> [   70.533577] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
> [   70.533593] pc : arch_local_irq_restore+0x4/0x8
> [   70.533605] lr : __slab_alloc+0xb0/0xc8
> [   70.533617] sp : ffff000005bd61a0
> [   70.533628] x29: ffff000005bd61a0 x28: 000000000000000e
> [   70.533653] x27: ffff0087b41c8ff8 x26: 0080000000000000
> [   70.533677] x25: ffffa000190db000 x24: ffff000e788d6c10
> [   70.533700] x23: ffffa00010cb41c8 x22: 00000000ffffffff
> [   70.533723] x21: 0000000000012b20 x20: ffff0087b41cde10
> [   70.533746] x19: 0000000000000000 x18: 1fffe001cf1193ca
> [   70.533768] x17: 0000000000000000 x16: 0000000000000000
> [   70.533791] x15: 0000000000071ccc x14: 0000000000071ccc
> [   70.533813] x13: ffff800000b7ac1d x12: 1fffe00000b7ac1c
> [   70.533836] x11: 1fffe00000b7ac1c x10: ffff800000b7ac1c
> [   70.533859] x9 : dfffa00000000000 x8 : ffff000005bd60e7
> [   70.533882] x7 : 00000000f2000000 x6 : dfffa00000000000
> [   70.533904] x5 : 00000000f2f2f200 x4 : 00000000f2f2f2f2
> [   70.533927] x3 : 1fffe00000b6ddca x2 : ffffa00019bf2000
> [   70.533950] x1 : 000000000190a943 x0 : 0000000000000000
> [   70.533973] Call trace:
> [   70.533987]  arch_local_irq_restore+0x4/0x8
> [   70.534000]  kmem_cache_alloc+0x35c/0x3c0
> [   70.534015]  fill_pool+0x278/0x588
> [   70.534028]  __debug_object_init+0x8c/0x1100
> [   70.534041]  debug_object_activate+0x234/0x448
> [   70.534055]  call_rcu+0x38/0x630
> [   70.534070]  put_object+0x84/0xc0
> [   70.534082]  __delete_object+0xc4/0x110
> [   70.534095]  delete_object_full+0x18/0x20
> [   70.534110]  kmemleak_free+0x2c/0x38
> [   70.534122]  slab_free_freelist_hook+0x15c/0x240
> [   70.534135]  kmem_cache_free+0x10c/0x518
> [   70.534150]  acpi_os_release_object+0xc/0x18
> [   70.534165]  acpi_ut_delete_object_desc+0xa8/0xac
> [   70.534177]  acpi_ut_update_ref_count.part.2+0x33c/0x788
> [   70.534190]  acpi_ut_update_object_reference+0x304/0x42c
> [   70.534203]  acpi_ut_remove_reference+0x64/0x74
> [   70.534218]  acpi_ds_store_object_to_local+0x2d8/0x300
> [   70.534231]  acpi_ex_store+0x600/0x658
> [   70.534244]  acpi_ex_opcode_1A_0T_1R+0x3e4/0xb34
> [   70.534257]  acpi_ds_exec_end_op+0x338/0xad0
> [   70.534270]  acpi_ps_parse_loop+0xdb4/0x1020
> [   70.534282]  acpi_ps_parse_aml+0x1f0/0x614
> [   70.534295]  acpi_ps_execute_method+0x500/0x508
> [   70.534308]  acpi_ns_evaluate+0x680/0x7b4
> [   70.534320]  acpi_ut_evaluate_object+0xc4/0x30c
> [   70.534333]  acpi_rs_get_method_data+0x84/0xd8
> [   70.534345]  acpi_walk_resources+0x13c/0x17c
> [   70.534359]  __acpi_dev_get_resources+0x150/0x1d8
> [   70.534371]  acpi_dev_get_resources+0x14/0x20
> [   70.534384]  acpi_init_device_object+0x698/0x10b8
> [   70.534396]  acpi_add_single_object+0xf8/0x1028
> [   70.534408]  acpi_bus_check_add+0x160/0x3f8
> [   70.534421]  acpi_ns_walk_namespace+0x1f4/0x298
> [   70.534433]  acpi_walk_namespace+0xa4/0xe8
> [   70.534446]  acpi_bus_scan+0xe0/0xf0
> [   70.534460]  acpi_scan_init+0x218/0x51c
> [   70.534472]  acpi_init+0x45c/0x4e4
> [   70.534485]  do_one_initcall+0x168/0xb60
> [   70.534498]  kernel_init_freeable+0x698/0x724
> [   70.534511]  kernel_init+0x10/0x11c
> [   70.534524]  ret_from_fork+0x10/0x18
> [  113.641710] rcu: INFO: rcu_sched self-detected stall on CPU
> [  113.641774] rcu:     25-....: (6495 ticks this GP)
> idle=3Dcbe/1/0x4000000000000002 softirq=3D772/772 fqs=3D3246
> [  113.641842]  (t=3D6500 jiffies g=3D309 q=3D1185230)
> [  113.641852] Task dump for CPU 25:
> [  113.641872] task:swapper/0       state:R  running task     stack:22624=
 pid:    1
> ppid:     0 flags:0x0000002a
> [  113.641907] Call trace:
> [  113.641927]  dump_backtrace+0x0/0x398
> [  113.641941]  show_stack+0x14/0x60
> [  113.641956]  sched_show_task.part.94+0x358/0x374
> [  113.641970]  sched_show_task+0x13c/0x1c0
> [  113.641983]  dump_cpu_task+0x80/0x90
> [  113.641996]  rcu_dump_cpu_stacks+0x1ac/0x1f8
> [  113.642012]  rcu_sched_clock_irq+0x1d94/0x2048
> [  113.642027]  update_process_times+0x30/0x1b8
> [  113.642041]  tick_periodic+0x6c/0x310
> [  113.642054]  tick_handle_periodic+0x70/0x140
> [  113.642070]  arch_timer_handler_phys+0x48/0x68
> [  113.642084]  handle_percpu_devid_irq+0x234/0xc08
> [  113.642099]  generic_handle_irq+0x74/0xa0
> [  113.642112]  __handle_domain_irq+0x98/0x158
> [  113.642126]  gic_handle_irq+0xd0/0x158
> [  113.642139]  el1_irq+0xbc/0x140
> [  113.642154]  arch_local_irq_restore+0x4/0x8
> [  113.642167]  kmem_cache_alloc+0x35c/0x3c0
> [  113.642182]  acpi_os_acquire_object+0x28/0x30
> [  113.642195]  acpi_ps_alloc_op+0x98/0x1d4
> [  113.642208]  acpi_ps_create_op+0x374/0x86c
> [  113.642221]  acpi_ps_parse_loop+0x3f4/0x1020
> [  113.642233]  acpi_ps_parse_aml+0x1f0/0x614
> [  113.642246]  acpi_ps_execute_method+0x500/0x508
> [  113.642258]  acpi_ns_evaluate+0x680/0x7b4
> [  113.642273]  acpi_ut_evaluate_object+0xc4/0x30c
> [  113.642286]  acpi_rs_get_method_data+0x84/0xd8
> [  113.642298]  acpi_walk_resources+0x13c/0x17c
> [  113.642313]  __acpi_dev_get_resources+0x150/0x1d8
> [  113.642325]  acpi_dev_get_resources+0x14/0x20
> [  113.642338]  acpi_init_device_object+0x698/0x10b8
> [  113.642351]  acpi_add_single_object+0xf8/0x1028
> [  113.642363]  acpi_bus_check_add+0x160/0x3f8
> acpi_bus_check_add at drivers/acpi/scan.c:1885
> [  113.642376]  acpi_ns_walk_namespace+0x1f4/0x298
> acpi_ns_walk_namespace at drivers/acpi/acpica/nswalk.c:237
> [  113.642389]  acpi_walk_namespace+0xa4/0xe8
> [  113.642401]  acpi_bus_scan+0xe0/0xf0
> [  113.642416]  acpi_scan_init+0x218/0x51c
> [  113.642428]  acpi_init+0x45c/0x4e4
> [  113.642441]  do_one_initcall+0x168/0xb60
> [  113.642455]  kernel_init_freeable+0x698/0x724
> [  113.642469]  kernel_init+0x10/0x11c
> [  113.642481]  ret_from_fork+0x10/0x18
> [  128.674020] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
>=20
> Signed-off-by: Qian Cai <cai@redhat.com>
> ---
>  drivers/acpi/acpica/nswalk.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
> index b7f3e8603ad8..216bf9e5a96e 100644
> --- a/drivers/acpi/acpica/nswalk.c
> +++ b/drivers/acpi/acpica/nswalk.c
> @@ -267,6 +267,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
>=20
>  				return_ACPI_STATUS(status);
>  			}
> +			cond_resched();

This is acpica code and cond_resched is specific to Linux so we cannot acce=
pt this in its current form.

The execution time of acpi_ns_walk_namespace is relative to the size of the=
 acpi namespace. This is determined by the size of firmware..
If the actual culprit was the traversing the ACPI namespace, you should hav=
e a soft lock up on acpi_load_tables which is the function that populates t=
he ACPI namespace. Your stack trace shows that Linux was able to get past t=
his point. Therefore, I'm led to think that the actual problem is the combi=
nation of walking the namespace + the handler invoked.

What happens if you add the cond_resched in acpi_bus_check_add?

Out of curiosity, does calling cond_resched guarantee that the acpi_init ca=
ll will finish before other kernel components that depend on ACPI are initi=
alized?

Erik
>  		}
>=20
>  		/*
> --
> 2.18.4

