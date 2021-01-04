Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05322E9FE4
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 23:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbhADWS1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 17:18:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:59755 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbhADWS1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Jan 2021 17:18:27 -0500
IronPort-SDR: yM+WL3IkPw4N775otBcNdB175uxLlZE5AChvCLJzeQq/Rt41hlgmtPMuw8puAYnOemmHK61ES7
 qiSgis/kgzdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156803278"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156803278"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 14:17:46 -0800
IronPort-SDR: MoFraJMMbJmeFy1y3O+hX+D4KjvSWqhfKmNu+VIP2wr0iOg5napc1FVgnHEmFAh7qRGYRVGBZ2
 5YvZ7ZF3A8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="421530306"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2021 14:17:46 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 14:17:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 14:17:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 14:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsW9a3cn0bLwvbYsEXSRqwMF5RmRTY0EiSH0MmXRHfE35uxioXorrBOJ65U45SSBknd1kY4xs6lMIlOR9zveRL2/NTpvbGJajJBUm948gMscAUroakrOj33JcPlJgs8GXT60UPPVipHt5yCZS8hziG2AbKfpym69JGQOTqQ8Tbh8W4OKqBHoKNL27USy34kW8gUryv3G6Y2RAeAZuV4dFsxxEzxV8xo+98tj2ChtwTbPC2N2a8hlzyC0BwV/4zKpBRVunFvQlWET6S0LrmM57+5TiMfGeJ8rv1N4vpe5Ciszx9nRTWUiRDKP2aZTWGlYB0MOqq1323hfhTLq6zMTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqjvqvux42zLbQ7+4UwqfakZMbQwvR9P0tOz+ndgj9g=;
 b=QhpghOhQGnuWHF/BuuoeyS8sPb9qqtWfekRuz5g4/kVpdXoMNfWQs2BnhxCxeQewi1IQhPktplt35OHLFKcpY4M0Y5PpL3Exa5nO8WpwZHQiQSrcw8HrFGxXLOEGWAg3bNhRdOAtwHndYMSyjWXrctFJNdDKNSiUypiIdr8HilfNzRc6atA6EalWy9TSPyzeHnnI83piVpKsirG7uSPRjfYSNxYKV9TSNMnWON7rzm0PxZqlcKwp0sfW9eDDRMR4EtNQKCzbLh7moSciG6GYWqPVbg2WmT1I7cYERqqAxlUEfL2uardiaO1YjkHn6VMBzmV4SocQUc3R7ig1f+adyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqjvqvux42zLbQ7+4UwqfakZMbQwvR9P0tOz+ndgj9g=;
 b=EGvmrMD9o2WBSc+HIXafydYuqCOnHOiQGlV2eCUwAxwTGtBjk1fsoL2jWeRLnEtKxenGsZ4bVREa5RkqI7+LV10nJe9ueHtKTKukWBPvbB2gYr17GeAv2hHfGo64qBqoI6/Wcy3cjWuj2zM15JmCPTNpjFIPKtuSiKSBIgQOGEo=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BYAPR11MB3109.namprd11.prod.outlook.com (2603:10b6:a03:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Mon, 4 Jan
 2021 22:17:44 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac88:24d1:1225:553d]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac88:24d1:1225:553d%3]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 22:17:44 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH 1/2] ACPICA: Fix race in GenericSerialBus (I2C) and GPIO
 OpRegion parameter handling
Thread-Topic: [PATCH 1/2] ACPICA: Fix race in GenericSerialBus (I2C) and GPIO
 OpRegion parameter handling
Thread-Index: AQHW25NrWzXvIr23REWQrLVwsahNEqoYF4Tw
Date:   Mon, 4 Jan 2021 22:17:43 +0000
Message-ID: <BYAPR11MB3256C957AA72754D07D6583F87D20@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20201226142830.48818-1-hdegoede@redhat.com>
 <20201226142830.48818-2-hdegoede@redhat.com>
In-Reply-To: <20201226142830.48818-2-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f15fd57c-c61c-4d5c-21b2-08d8b0fe8f02
x-ms-traffictypediagnostic: BYAPR11MB3109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3109C3FE40D52ED0C8DA804E87D20@BYAPR11MB3109.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:222;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofyDke5aC77lK7hpN0QHlJDpNSSV4qV/kPmFnJ9WzwNAdEp79QunpHevYZ+sKrrsR3Y1a+h6tBHLADgzgWrMhCeOGrBtvaL2wd4Qqf4WuqoqG8T6OOBr5QI718Ee4VV3mnZE0DviAU1OliO/zSQZCEYz8ak5c+JZjjvLj14B9ALIjz5tkd/sbJUg+dqlSMT9qM0hAllY2+/C6tbrDZAgRLljDQyRo+QtihktueazA6l7uKgxjjsAnpE/vRVNGozgw5X9KyLSgdb8ZOJe7l5P50WQoCnDOYiZrTJh0Je5UJuc4bEr783xz3+OOrt/B7pfYsD1OYGfIOd9KD/A4q+/kCpVZSIjW51AjUeVeMVbEiFRPBuKg21CjQR5CC+MY9C3S+A0TmQ7jXOlkZNCkN4drw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(26005)(2906002)(8936002)(7696005)(33656002)(6636002)(186003)(55016002)(9686003)(316002)(83380400001)(54906003)(110136005)(6506007)(5660300002)(53546011)(52536014)(8676002)(4326008)(478600001)(64756008)(66556008)(66446008)(86362001)(71200400001)(66476007)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qMwRccC+UiOb9GK7IJThif/HVb0fVw1DzlJv0WJVI2BY6t1ovPRBKXr1e8zp?=
 =?us-ascii?Q?MsFvmNCjWQtyhBR6riIxarv0m4AMzLyxA04Zpi5+wBkxRGWKWLQ0BJF2ywgw?=
 =?us-ascii?Q?q1dckXeT3hRJe39IuusAId9OewY1JYkhM7JLbha8eSGffAgDp6mQFChLQlfm?=
 =?us-ascii?Q?CK2CUy9o73qoG89dCglSsg7pnETy6vWmNtdAFBlnTZbK415WdYLArcloawc+?=
 =?us-ascii?Q?vJC2/OPIFeVl8j3H/swoLH5+mVnvPdyJF5rP51eVq/8L4l47yNw/aWFq0vFz?=
 =?us-ascii?Q?yq92wD6ZvSC/vlHtZE9+1wDuWicr7iQLnHNhlCG/DHYmXNw7SofQ7xjLg55b?=
 =?us-ascii?Q?HKqLTW5VwNUklN7h4zublTvqAZnLs0idLpQMd0L75IqCWHW2XUVNVrapQ6YO?=
 =?us-ascii?Q?55XoghWp/NoKYRQRyYw248bVMCQ/O2zNsd1e62MRnV8VW6MWww8GAnV2BLuy?=
 =?us-ascii?Q?KZweFFwcN60/kUMzuao32VTeeslw+3XzOKTSEr2GGdsmUG9GtuY8Njv8a99h?=
 =?us-ascii?Q?pbCMPpuNj+59lU3eZzUSfz5qYOLwcF0uP2rXyzjJP/MM3JUctZo5MVDCEhOc?=
 =?us-ascii?Q?9pjd0SDh7QV13BGMSySFCwaBS3uxC6g2dBnSkci1AwF7gZrJvBqE98Q1GR7v?=
 =?us-ascii?Q?ekslKrlIWCtEyP/bK2e8MNB7fj14qRINsFNoH7VSkMgMY3pP8mHPu2Vco1b4?=
 =?us-ascii?Q?VaYqnTd8u0+ClCzoY7Lr/htbYkp7Ip/DNMDvd9RrZoneE6D2qLL0RymEj3qy?=
 =?us-ascii?Q?UUY6jJscH5rYdOSrKNVlyOa0tUt5Yl5vmOaEAynv3j0AA02X88dHmOqwo7wW?=
 =?us-ascii?Q?XOcLNe3uz20z8Nytm8EK+MFiFhEpGtCBO0ZzaTMLHY7d31P6zR2SQ7lFcz+r?=
 =?us-ascii?Q?yMMugs6dNQp6ZMqr+ziyT7K7hFZ8yxicqXJjXAua/PtLt6W0J2FJWCh4U/OA?=
 =?us-ascii?Q?NxJGmrsRSrN2QAt8M8oggFs+7Wi0bGkBN8AnzwiooYo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15fd57c-c61c-4d5c-21b2-08d8b0fe8f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 22:17:43.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zn9/AItgskzVrlYtdVcJ5Wt+JeZEC8G8zTmbRzT6OA5NooBfZS3q4cRYMNFwsabG1FFEQMBaiSCkp0Av7714QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3109
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hans,
Could you make a pull request for this (and any related patches) on our git=
hub?
Thanks,
Bob


-----Original Message-----
From: Hans de Goede <hdegoede@redhat.com>=20
Sent: Saturday, December 26, 2020 6:28 AM
To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Mo=
ore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org; devel@=
acpica.org
Subject: [PATCH 1/2] ACPICA: Fix race in GenericSerialBus (I2C) and GPIO Op=
Region parameter handling

The handling of the GenericSerialBus (I2C) and GPIO OpRegions in
acpi_ev_address_space_dispatch() passes a number of extra parameters to the=
 address-space handler through the address-space context pointer (instead o=
f using more function parameters).

The context is shared between threads, so if multiple threads try to call t=
he handler for the same address-space at the same time, then a second threa=
d could change the parameters of a first thread while the handler is runnin=
g for the first thread.

An example of this race hitting is the Lenovo Yoga Tablet2 1015L, where the=
re are both AttribBytes accesses and AttribByte accesses to the same addres=
s-space. The AttribBytes access stores the number of bytes to transfer in c=
ontext->access_length. Where as for the AttribByte access the number of byt=
es to transfer is always 1 and field_obj->field.access_length is unused (so=
 0). Both types of accesses racing from different threads leads to the foll=
owing problem:

1. Thread a. starts an AttribBytes access, stores a non 0 value from field_=
obj->field.access_length in context->access_length 2. Thread b. starts an A=
ttribByte access, stores 0 in
context->access_length
3. Thread a. calls i2c_acpi_space_handler() (under Linux). Which sees that =
the access-type is ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE and calls acpi_gsb_i2c_=
read_bytes(..., context->access_length) 4. At this point context->access_le=
ngth is 0 (set by thread b.) rather then the field_obj->field.access_length=
 value from thread a.
This 0 length reads leads to the following errors being logged:

 i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0, read)  i2c =
i2c-0: i2c read 0 bytes from client@0x78 starting at reg 0x0 failed, error:=
 -95

Note this is just an example of the problems which this race can cause.
There are likely many more (sporadic) problems caused by this race.

This commit adds a new context_mutex to acpi_object_addr_handler and makes =
acpi_ev_address_space_dispatch() take that mutex when using the shared cont=
ext to pass extra parameters to an address-space handler, fixing this race.

Note the new mutex must be taken *after* exiting the interpreter, therefor =
the existing acpi_ex_exit_interpreter() call is moved to above the code whi=
ch stores the extra parameters in the context.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/acobject.h  |  1 +
 drivers/acpi/acpica/evhandler.c |  6 ++++  drivers/acpi/acpica/evregion.c =
 | 61 ++++++++++++++++++++++++---------  drivers/acpi/acpica/evxfregn.c  | =
 1 +
 4 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.=
h index 9f0219a8cb98..dd7efafcb103 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -284,6 +284,7 @@ struct acpi_object_addr_handler {
 	acpi_adr_space_handler handler;
 	struct acpi_namespace_node *node;	/* Parent device */
 	void *context;
+	acpi_mutex context_mutex;
 	acpi_adr_space_setup setup;
 	union acpi_operand_object *region_list;	/* Regions using this handler */
 	union acpi_operand_object *next;
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandle=
r.c index 5884eba047f7..347199f29afe 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -489,6 +489,12 @@ acpi_ev_install_space_handler(struct acpi_namespace_no=
de *node,
=20
 	/* Init handler obj */
=20
+	status =3D acpi_os_create_mutex(&handler_obj->address_space.context_mutex=
);
+	if (ACPI_FAILURE(status)) {
+		acpi_ut_remove_reference(handler_obj);
+		goto unlock_and_exit;
+	}
+
 	handler_obj->address_space.space_id =3D (u8)space_id;
 	handler_obj->address_space.handler_flags =3D flags;
 	handler_obj->address_space.region_list =3D NULL; diff --git a/drivers/acp=
i/acpica/evregion.c b/drivers/acpi/acpica/evregion.c index 21ff341e34a4..8e=
84eb0641e0 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -112,6 +112,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_objec=
t *region_obj,
 	union acpi_operand_object *region_obj2;
 	void *region_context =3D NULL;
 	struct acpi_connection_info *context;
+	acpi_mutex context_mutex;
+	bool context_locked;
 	acpi_physical_address address;
=20
 	ACPI_FUNCTION_TRACE(ev_address_space_dispatch);
@@ -136,6 +138,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_objec=
t *region_obj,
 	}
=20
 	context =3D handler_desc->address_space.context;
+	context_mutex =3D handler_desc->address_space.context_mutex;
+	context_locked =3D false;
=20
 	/*
 	 * It may be the case that the region has never been initialized.
@@ -204,6 +208,23 @@ acpi_ev_address_space_dispatch(union acpi_operand_obje=
ct *region_obj,
 	handler =3D handler_desc->address_space.handler;
 	address =3D (region_obj->region.address + region_offset);
=20
+	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
+			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
+			  &region_obj->region.handler->address_space, handler,
+			  ACPI_FORMAT_UINT64(address),
+			  acpi_ut_get_region_name(region_obj->region.
+						  space_id)));
+
+	if (!(handler_desc->address_space.handler_flags &
+	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
+		/*
+		 * For handlers other than the default (supplied) handlers, we must
+		 * exit the interpreter because the handler *might* block -- we don't
+		 * know what it will do, so we can't hold the lock on the interpreter.
+		 */
+		acpi_ex_exit_interpreter();
+	}
+
 	/*
 	 * Special handling for generic_serial_bus and general_purpose_io:
 	 * There are three extra parameters that must be passed to the @@ -212,6 =
+233,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region=
_obj,
 	 *   2) Length of the above buffer
 	 *   3) Actual access length from the access_as() op
 	 *
+	 * Since we pass these extra parameters via the context, which is
+	 * shared between threads, we must lock the context to avoid these
+	 * parameters being changed from another thread before the handler
+	 * has completed running.
+	 *
 	 * In addition, for general_purpose_io, the Address and bit_width fields
 	 * are defined as follows:
 	 *   1) Address is the pin number index of the field (bit offset from
@@ -221,6 +247,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_obje=
ct *region_obj,
 	if ((region_obj->region.space_id =3D=3D ACPI_ADR_SPACE_GSBUS) &&
 	    context && field_obj) {
=20
+		status =3D acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			goto re_enter_interpreter;
+		}
+
+		context_locked =3D true;
+
 		/* Get the Connection (resource_template) buffer */
=20
 		context->connection =3D field_obj->field.resource_buffer; @@ -230,6 +263=
,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj=
,
 	if ((region_obj->region.space_id =3D=3D ACPI_ADR_SPACE_GPIO) &&
 	    context && field_obj) {
=20
+		status =3D acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			goto re_enter_interpreter;
+		}
+
+		context_locked =3D true;
+
 		/* Get the Connection (resource_template) buffer */
=20
 		context->connection =3D field_obj->field.resource_buffer; @@ -239,28 +27=
9,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_ob=
j,
 		bit_width =3D field_obj->field.bit_length;
 	}
=20
-	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-			  "Handler %p (@%p) Address %8.8X%8.8X [%s]\n",
-			  &region_obj->region.handler->address_space, handler,
-			  ACPI_FORMAT_UINT64(address),
-			  acpi_ut_get_region_name(region_obj->region.
-						  space_id)));
-
-	if (!(handler_desc->address_space.handler_flags &
-	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
-		/*
-		 * For handlers other than the default (supplied) handlers, we must
-		 * exit the interpreter because the handler *might* block -- we don't
-		 * know what it will do, so we can't hold the lock on the interpreter.
-		 */
-		acpi_ex_exit_interpreter();
-	}
-
 	/* Call the handler */
=20
 	status =3D handler(function, address, bit_width, value, context,
 			 region_obj2->extra.region_context);
=20
+	if (context_locked)
+		acpi_os_release_mutex(context_mutex);
+
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Returned by Handler for [%s]",
 				acpi_ut_get_region_name(region_obj->region.
@@ -277,6 +303,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_objec=
t *region_obj,
 		}
 	}
=20
+re_enter_interpreter:
 	if (!(handler_desc->address_space.handler_flags &
 	      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)) {
 		/*
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.=
c index da97fd0c6b51..74d0ee8a5736 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -201,6 +201,7 @@ acpi_remove_address_space_handler(acpi_handle device,
=20
 			/* Now we can delete the handler object */
=20
+			acpi_os_release_mutex(handler_obj->address_space.context_mutex);
 			acpi_ut_remove_reference(handler_obj);
 			goto unlock_and_exit;
 		}
--
2.28.0

