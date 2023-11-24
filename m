Return-Path: <linux-acpi+bounces-1819-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1707F7993
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57FEB20B7B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977C364A4
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A11B5;
	Fri, 24 Nov 2023 08:05:11 -0800 (PST)
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ScKZ640DQz684Xd;
	Sat, 25 Nov 2023 00:05:02 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 16:05:08 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 24 Nov 2023 16:05:08 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: kernel test robot <lkp@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>
Subject: RE: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Thread-Topic: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Thread-Index: AQHaHjSmCJSxSfmspkqILDwEeyXpzrCJdYKAgAAt7ZA=
Date: Fri, 24 Nov 2023 16:05:08 +0000
Message-ID: <6629bb080d9d4edea68866860d73fad7@huawei.com>
References: <20231123174355.1176-2-shiju.jose@huawei.com>
 <202311241526.R8n6AibH-lkp@intel.com>
In-Reply-To: <202311241526.R8n6AibH-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected

Hi,

These warnings are fixed. Will add in the next version.

Thanks,
Shiju

>-----Original Message-----
>From: kernel test robot <lkp@intel.com>
>Sent: 24 November 2023 13:20
>To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
>mm@kvack.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com
>Cc: oe-kbuild-all@lists.linux.dev; linux-acpi@vger.kernel.org; linux-
>kernel@vger.kernel.org; david@redhat.com; Vilas.Sridharan@amd.com;
>leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
>jiaqiyan@google.com; tony.luck@intel.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; rafael@kernel.org; lenb@kernel.org;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; mike.malvestuto@intel.com
>Subject: Re: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES
>mailbox command
>
>Hi,
>
>kernel test robot noticed the following build warnings:
>
>[auto build test WARNING on krzk-mem-ctrl/for-next] [also build test WARNI=
NG
>on linus/master v6.7-rc2 next-20231124] [If your patch is applied to the w=
rong
>git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-c=
om/cxl-
>mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231124-014622
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctr=
l.git
>for-next
>patch link:    https://lore.kernel.org/r/20231123174355.1176-2-
>shiju.jose%40huawei.com
>patch subject: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES
>mailbox command
>config: i386-randconfig-061-20231124 (https://download.01.org/0day-
>ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/config)
>compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git
>ae42196bc493ffe877a7e3dff8be32035dea4d07)
>reproduce (this is a W=3D1 build): (https://download.01.org/0day-
>ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new versi=
on of the
>same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes:
>| https://lore.kernel.org/oe-kbuild-all/202311241526.R8n6AibH-lkp@intel.
>| com/
>
>sparse warnings: (new ones prefixed by >>)
>>> drivers/cxl/core/mbox.c:1317:30: sparse: sparse: cast from restricted
>>> __le32
>
>vim +1317 drivers/cxl/core/mbox.c
>
>  1305
>  1306	int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  1307							struct
>cxl_mbox_get_supp_feats_in *pi,
>  1308							void *feats_out)
>  1309	{
>  1310		struct cxl_mbox_cmd mbox_cmd;
>  1311		int rc;
>  1312
>  1313		mbox_cmd =3D (struct cxl_mbox_cmd) {
>  1314			.opcode =3D CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>  1315			.size_in =3D sizeof(*pi),
>  1316			.payload_in =3D pi,
>> 1317			.size_out =3D (size_t)pi->count,
>  1318			.payload_out =3D feats_out,
>  1319			.min_out =3D sizeof(struct cxl_mbox_get_supp_feats_out),
>  1320		};
>  1321		rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
>  1322		if (rc < 0)
>  1323			return rc;
>  1324
>  1325		return 0;
>  1326	}
>  1327	EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>  1328
>
>--
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki

