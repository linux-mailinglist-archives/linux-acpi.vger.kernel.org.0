Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3008F19770A
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgC3Iww (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 04:52:52 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:36325 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728759AbgC3Iwv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Mar 2020 04:52:51 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Mon, 30 Mar 2020 08:51:52 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 30 Mar 2020 08:50:42 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 30 Mar 2020 08:50:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNIu2bops8/fziS5ITe4H4T0Uo+3SeBZTzNlFsbb7Tl5AcVXtp17ypj+9jiP7LzXL0P17IvO7iHUoHIHzYcJC11QyC7kCdVCUPTbqk9qOSIxaZ/FOmegZWtR99QT8nMeK9sG+bQ850Ldw7OSpROtuNSlTnNpSKAcuCwKN5o+kQbFwIzCpJxQQAS9SFQWucERE+DtgObN6sgcpKo6ZQ4Ksds9k9WP3QCsXrPlJVAY+Hsf4fcKhHUcB6HWR2CHl1kePPxrMdHAB0EQySUEfX5NAHH0DgHFhsCQsHCwlf2pM28Ct7NnriMpLghwMudD6F6b6DnST4WHhAHFT/w5f/d/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjclFY/MtRW7SAhnUu7zukiq+B2B8esnLOCJDvYKo0o=;
 b=Fz3I20qkQmB7EdLkvriDtZm1pD3RYdAPL6vAU8GQLmPUJEFXu1KjrFPOVDdJ9mt6ZRDBHQa3gYHYSfZB5edq3nMhXjjhwauxBUX21q7L2zmwqlevUvj20gCBe0itL9T2x8Ovp4ssxsee4TDCmpPJ5xgG6yoNyDkqcWcfsiX062tYl0OLJE843uNVY4f9/pCBcAfsH0yzNehJmLcfbUOKIv+zSdrOa+QZijeTEPCnmlO0P8Gho12gx45Exx34d878lJfLeLM7T7XsAum7LuDLf4G+9j/p288y5L7NQvw6xXryzCPPFz2/4gwfizdkTuXwvwD7Sh9ylT//eZy1firg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SN1PR18MB2317.namprd18.prod.outlook.com (2603:10b6:802:2b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 08:50:40 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9%5]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 08:50:40 +0000
Date:   Mon, 30 Mar 2020 16:50:20 +0800
From:   Chester Lin <clin@suse.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.kaneda@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devel@acpica.org>,
        <jlee@suse.com>, <mhocko@suse.com>, <clin@suse.com>
Subject: Re: [RFC PATCH 1/3] ACPI: scan: add userland notification while
 handling eject events
Message-ID: <20200330085020.GA26252@linux-8mug>
References: <20200327112247.17691-1-clin@suse.com>
 <20200327112247.17691-2-clin@suse.com>
 <20200327113842.GA1736848@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200327113842.GA1736848@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::31) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.62.204) by LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 08:50:34 +0000
X-Originating-IP: [118.166.62.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcf6f995-d5e9-4afb-b2a2-08d7d4876c68
X-MS-TrafficTypeDiagnostic: SN1PR18MB2317:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR18MB23170B1F9F2F7B67A15D0C6CADCB0@SN1PR18MB2317.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(6666004)(33716001)(6496006)(8676002)(55236004)(66476007)(5660300002)(9686003)(55016002)(86362001)(26005)(66556008)(478600001)(52116002)(16526019)(186003)(956004)(15650500001)(316002)(33656002)(81166006)(2906002)(4326008)(107886003)(66946007)(1076003)(81156014)(8936002)(6916009);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L93aTK60bb7Iq12NHJDz6SI6SJgdZfTNxYXLEax4bY34mo6pOdYSkbxNOGcFoL42e/6aownmIg5t1XeTEmRGseNB55rj5JXx0Ybiu49WaVwcF9qHLKmExGBfNQ4h9kDXnDpElEhQNNtvoThvWNCzfJeGhNFL01foeb1O1v7WMsJxXOjpVjXpyUx3QvufezYArbnqsRhX0JW02eY5VS4UecTJeFbZFOaTODNe+9OX5kXOq4760ZL1Wvian4bo+YwLQ9EXO5j83CU7YLACE+WR/AsdCAYaV/s/dZZ/B42gOMOq5ngmzHXCCEq7805CNULlLm4FSlvdrsMt3uXJp1sYhlgEcVLTMMc3Y936RZNNoYmBED+o2os6zN1T/UBdcYCC2odqt2ih0i9ZLakt0u+7YflvNiptxLZ2CD0ie1tPT2nuiPdvtaCgkrT3kNxyyFUm
X-MS-Exchange-AntiSpam-MessageData: LBut1NiCAXKyf7RFE23PPL/ZB8aIiTPpwdniup+jzXBQM2OVEJ4jGfXcnnYdo7c0lCtHCBRKaTlxFxCTjwariZ89AQLYnp1jUgLFivRUzWDoHTQmkcchNZ+eRcxt4WORS8p4bY995bJaqi916AejXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf6f995-d5e9-4afb-b2a2-08d7d4876c68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 08:50:40.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB1lh5kyMibXM474/aAUieW7DX6AW1aeI04tIZB2pOmiRQRe1wfvEysvYtRiqqlQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2317
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Greg,

On Fri, Mar 27, 2020 at 12:38:42PM +0100, Greg KH wrote:
> On Fri, Mar 27, 2020 at 07:22:45PM +0800, Chester Lin wrote:
> > Add a request_offline attribute in order to tell the kernel if it's
> > required to send notifications to userland first while handling an eject
> > event. Userland will have to put the target device offline when this
> > attribute is set.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-acpi | 16 ++++++++++
> >  drivers/acpi/device_sysfs.c              | 40 +++++++++++++++++++++++-
> >  drivers/acpi/scan.c                      | 39 +++++++++++++++++++----
> >  include/acpi/acpi_bus.h                  |  1 +
> >  4 files changed, 89 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> > index e7898cfe5fb1..b9c467704889 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > @@ -93,3 +93,19 @@ Description:
> >  		hardware, if the _HRV control method is present.  It is mostly
> >  		useful for non-PCI devices because lspci can list the hardware
> >  		version for PCI devices.
> > +
> > +What:		/sys/bus/acpi/devices/.../request_offline
> > +Date:		Mar, 2020
> > +Contact:	Chester Lin <clin@suse.com>
> > +Description:
> > +		(RW) Allows the userland to receive offline requests when
> > +		devices are planning to be ejected.
> > +
> > +		If bit [0] is clear, the kernel will automatically try putting
> > +		the target offline before the target can be ejected.
> > +
> > +		If bit [0] is set, a uevent will be sent to userland as an
> > +		offline request and userland is responsible for handling offline
> > +		operations before the target can be ejected. This approach
> > +		provides flexibility while some applications could need more
> > +		time to release resources.
> 
> Don't use "bit", use 1/0/y/n/Y/N as the kernel will parse all of that
> for you with the kstrtobool() which was created just for this type of
> sysfs file.
> 

I'm sorry for this mistake. Based on my code they should be ASCII char '1' and
'0' but not bitwise ops. I will fix this description.

> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 96869f1538b9..453bd1b9edf5 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -506,6 +506,37 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(status);
> >  
> > +static ssize_t request_offline_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> > +
> > +	return sprintf(buf, "%u\n", acpi_dev->request_offline?1:0);
> > +}
> > +
> > +static ssize_t request_offline_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> > +
> > +	if (!count)
> > +		return -EINVAL;
> > +
> > +	switch (buf[0]) {
> > +	case '0':
> > +		acpi_dev->request_offline = false;
> > +		break;
> > +	case '1':
> > +		acpi_dev->request_offline = true;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(request_offline);
> > +
> >  /**
> >   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
> >   * @dev: ACPI device object.
> > @@ -580,6 +611,11 @@ int acpi_device_setup_files(struct acpi_device *dev)
> >  		result = device_create_file(&dev->dev, &dev_attr_eject);
> >  		if (result)
> >  			return result;
> > +
> > +		result = device_create_file(&dev->dev,
> > +					    &dev_attr_request_offline);
> > +		if (result)
> > +			return result;
> >  	}
> >  
> >  	if (dev->flags.power_manageable) {
> > @@ -623,8 +659,10 @@ void acpi_device_remove_files(struct acpi_device *dev)
> >  	/*
> >  	 * If device has _EJ0, remove 'eject' file.
> >  	 */
> > -	if (acpi_has_method(dev->handle, "_EJ0"))
> > +	if (acpi_has_method(dev->handle, "_EJ0")) {
> >  		device_remove_file(&dev->dev, &dev_attr_eject);
> > +		device_remove_file(&dev->dev, &dev_attr_request_offline);
> 
> You all really should be using an attribute group and the is_visible()
> callback to handle all of this for you automatically.
> 
> But that's a separate issue than this specific patch.
> 

That sounds good to me. I will refine this part by declaring an attribute_group
with a is_visible() callback.

> > +	}
> >  
> >  	if (acpi_has_method(dev->handle, "_SUN"))
> >  		device_remove_file(&dev->dev, &dev_attr_sun);
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 6d3448895382..1cb39c5360cf 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -145,6 +145,7 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
> >  	struct acpi_device_physical_node *pn;
> >  	bool second_pass = (bool)data;
> >  	acpi_status status = AE_OK;
> > +	char *envp[] = { "EVENT=offline", NULL };
> >  
> >  	if (acpi_bus_get_device(handle, &device))
> >  		return AE_OK;
> > @@ -166,7 +167,18 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
> >  		} else {
> >  			pn->put_online = false;
> >  		}
> > -		ret = device_offline(pn->dev);
> > +
> > +		/* Don't offline directly but need to notify userland first */
> > +		if (device->request_offline) {
> > +			if (pn->dev->offline)
> > +				ret = 0;
> > +			else
> > +				ret = kobject_uevent_env(&pn->dev->kobj,
> > +							KOBJ_CHANGE, envp);
> 
> So this is a userspace visable change with regards to kobject events?
> 
> Are you sure that is ok?
> 

Since udev can see kobject events when devices are added, I haven't seen any
risk if we make offline events visible too. Besides, normally online/eject
attributes can only be written by root in userspace.

Thanks,
Chester Lin
