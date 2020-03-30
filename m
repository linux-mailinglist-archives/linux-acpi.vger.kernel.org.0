Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312AC1977A2
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 11:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgC3JR0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 05:17:26 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:59956 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727696AbgC3JR0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Mar 2020 05:17:26 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Mon, 30 Mar 2020 09:16:01 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 30 Mar 2020 09:11:40 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 30 Mar 2020 09:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z64NwLckWoqzsgGFf+5KuzcXrLhm44ignyXvXy8H3kYQ2T1skxgYhUWBj5cKiWMhzuTWueaDKR5mfcJWSxAUZmm9qQZxVntj2beSu3KKvZFMjMgP3wFDn0Nvk2lgJxEene30yPhrk4clGO0BkMPU2o9t9feR+5YW1cATH4CYHqaq6HmkfgfrwS7wRwEzF7Er7RLUzN2GxDETkFeUlRhTd/zJFFoLkr4m8pPzYkFvrHmEYxg+zMPR/qo99Evb9VlVOxxJZ3AfXWZM8ATmFp0Xv8i3MUNPElnRTZdUhq/rG2z7t2HmeHjJSdhL2CdwatEoZAXfL52r0iTlcJFT9nB+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy03OB+3cYv7xLechxW8dqEigLCkE+lI4R5cBhyrK5M=;
 b=NxxQx/78cMzYqXnzhYLLJyFBgxBkHDR646TqT8OD3klbWe/ZtHP9RjU5nsp5hJ+ZfEvZk1nVJHEV54lnbSf3xgJFOf8UfFn0gX6IfsYTxN8PugIMWB7T+Cdv+XRpvE3taCH0GCsBtmy3nwWnNp+oGvfO83KqltvflvR6WvMTJq5VgnlrwDw3XzURX2mHsZDS2JunvNYXLfR1heV/3Feukus0EvxGwI037uTSTLLJpnsnOniBDghoLrK5pvvwNgIKCG5fAFprp49wboJfQ2/adolFXE1uV0gfhrCt1M132s4g0kDagbDmj9P5zNdF2V2OPNa9hRmKd1sLRTGyOmHZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SN1PR18MB2112.namprd18.prod.outlook.com (2603:10b6:802:28::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Mon, 30 Mar
 2020 09:11:38 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9%5]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 09:11:38 +0000
Date:   Mon, 30 Mar 2020 17:11:19 +0800
From:   Chester Lin <clin@suse.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.kaneda@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devel@acpica.org>,
        <jlee@suse.com>, <mhocko@suse.com>, <clin@suse.com>
Subject: Re: [RFC PATCH 1/3] ACPI: scan: add userland notification while
 handling eject events
Message-ID: <20200330091119.GA18816@linux-8mug>
References: <20200327112247.17691-1-clin@suse.com>
 <20200327112247.17691-2-clin@suse.com>
 <20200327113842.GA1736848@kroah.com>
 <20200330085020.GA26252@linux-8mug>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200330085020.GA26252@linux-8mug>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: LO2P265CA0429.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::33) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.62.204) by LO2P265CA0429.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 09:11:31 +0000
X-Originating-IP: [118.166.62.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a1397a-b65c-4041-d760-08d7d48a595e
X-MS-TrafficTypeDiagnostic: SN1PR18MB2112:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR18MB211241710E17D5FCF0BE3510ADCB0@SN1PR18MB2112.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR18MB2126.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(2906002)(66476007)(8676002)(66556008)(15650500001)(66946007)(52116002)(81156014)(6496006)(8936002)(5660300002)(33656002)(9686003)(55016002)(55236004)(6916009)(107886003)(16526019)(86362001)(186003)(26005)(4326008)(33716001)(1076003)(316002)(81166006)(956004)(478600001)(6666004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fbu9IuK8GQIZCrl0X1zrfVcbhbZvlAUM+eFs3qEc2quynj67bOTo3juCT4491779eexUDaH2u2NxFbElzgZsjdC3y89fWHgkataBS41b+8ro/BEq2lghBERIK6w3azyu8Zkrqeakgebut+SW8t6Bze54+Kt/WEV/u+gxJyl9eB8KC18cezFRbNw6HY+NBcE/IAzrUBpPTk0Ud7nfDh83iWAn1cuaY06Z6rWBNSf/nDk5N0F8l0bFECjVCW1qeIDUnn5NR3H5KJhh/kOSHngF00NaUyg3NDyKIUT4uqRwWfzs2vzQMqjnAaBZFbHkTjoCJ7sqNHR+vF84M8anujm08CFhG7uO4eX0AsY19elCdWRwApwM1EVwqWOJBu3CNzGaAzpNQ46+BqgGU61ffsHTMRC0M0VvlQluQ6EASJ28UQcXqRXFusdd9FPEfRy1ktA
X-MS-Exchange-AntiSpam-MessageData: Nzu2ycPvN7lkDUSUMPHhd+EHJl6b5688+pa/oIzo5fTL4s1lyq1eKyED87TpfUc33q89ZhmRkbKElPp9IrJArLBu1Qt70tKEj6/MijIH8n/gOvluFuFl18my2WkunadcX4ORsCcoLEm4DKfpfwLBKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a1397a-b65c-4041-d760-08d7d48a595e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 09:11:38.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqfJVO4euxh7PYcraisf0uC+b8MSo0lnWDzSqtVnO41bDWZGgrOfOO0DtYSLrFdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2112
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 30, 2020 at 04:50:20PM +0800, Chester Lin wrote:
> Hi Greg,
> 
> On Fri, Mar 27, 2020 at 12:38:42PM +0100, Greg KH wrote:
> > On Fri, Mar 27, 2020 at 07:22:45PM +0800, Chester Lin wrote:
> > > Add a request_offline attribute in order to tell the kernel if it's
> > > required to send notifications to userland first while handling an eject
> > > event. Userland will have to put the target device offline when this
> > > attribute is set.
> > > 
> > > Signed-off-by: Chester Lin <clin@suse.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-acpi | 16 ++++++++++
> > >  drivers/acpi/device_sysfs.c              | 40 +++++++++++++++++++++++-
> > >  drivers/acpi/scan.c                      | 39 +++++++++++++++++++----
> > >  include/acpi/acpi_bus.h                  |  1 +
> > >  4 files changed, 89 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> > > index e7898cfe5fb1..b9c467704889 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > > @@ -93,3 +93,19 @@ Description:
> > >  		hardware, if the _HRV control method is present.  It is mostly
> > >  		useful for non-PCI devices because lspci can list the hardware
> > >  		version for PCI devices.
> > > +
> > > +What:		/sys/bus/acpi/devices/.../request_offline
> > > +Date:		Mar, 2020
> > > +Contact:	Chester Lin <clin@suse.com>
> > > +Description:
> > > +		(RW) Allows the userland to receive offline requests when
> > > +		devices are planning to be ejected.
> > > +
> > > +		If bit [0] is clear, the kernel will automatically try putting
> > > +		the target offline before the target can be ejected.
> > > +
> > > +		If bit [0] is set, a uevent will be sent to userland as an
> > > +		offline request and userland is responsible for handling offline
> > > +		operations before the target can be ejected. This approach
> > > +		provides flexibility while some applications could need more
> > > +		time to release resources.
> > 
> > Don't use "bit", use 1/0/y/n/Y/N as the kernel will parse all of that
> > for you with the kstrtobool() which was created just for this type of
> > sysfs file.
> > 
> 
> I'm sorry for this mistake. Based on my code they should be ASCII char '1' and
> '0' but not bitwise ops. I will fix this description.
> 
> > > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > > index 96869f1538b9..453bd1b9edf5 100644
> > > --- a/drivers/acpi/device_sysfs.c
> > > +++ b/drivers/acpi/device_sysfs.c
> > > @@ -506,6 +506,37 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> > >  }
> > >  static DEVICE_ATTR_RO(status);
> > >  
> > > +static ssize_t request_offline_show(struct device *dev,
> > > +		struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> > > +
> > > +	return sprintf(buf, "%u\n", acpi_dev->request_offline?1:0);
> > > +}
> > > +
> > > +static ssize_t request_offline_store(struct device *dev,
> > > +		struct device_attribute *attr, const char *buf, size_t count)
> > > +{
> > > +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> > > +
> > > +	if (!count)
> > > +		return -EINVAL;
> > > +
> > > +	switch (buf[0]) {
> > > +	case '0':
> > > +		acpi_dev->request_offline = false;
> > > +		break;
> > > +	case '1':
> > > +		acpi_dev->request_offline = true;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return count;
> > > +}
> > > +static DEVICE_ATTR_RW(request_offline);
> > > +
> > >  /**
> > >   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
> > >   * @dev: ACPI device object.
> > > @@ -580,6 +611,11 @@ int acpi_device_setup_files(struct acpi_device *dev)
> > >  		result = device_create_file(&dev->dev, &dev_attr_eject);
> > >  		if (result)
> > >  			return result;
> > > +
> > > +		result = device_create_file(&dev->dev,
> > > +					    &dev_attr_request_offline);
> > > +		if (result)
> > > +			return result;
> > >  	}
> > >  
> > >  	if (dev->flags.power_manageable) {
> > > @@ -623,8 +659,10 @@ void acpi_device_remove_files(struct acpi_device *dev)
> > >  	/*
> > >  	 * If device has _EJ0, remove 'eject' file.
> > >  	 */
> > > -	if (acpi_has_method(dev->handle, "_EJ0"))
> > > +	if (acpi_has_method(dev->handle, "_EJ0")) {
> > >  		device_remove_file(&dev->dev, &dev_attr_eject);
> > > +		device_remove_file(&dev->dev, &dev_attr_request_offline);
> > 
> > You all really should be using an attribute group and the is_visible()
> > callback to handle all of this for you automatically.
> > 
> > But that's a separate issue than this specific patch.
> > 
> 
> That sounds good to me. I will refine this part by declaring an attribute_group
> with a is_visible() callback.
> 
> > > +	}
> > >  
> > >  	if (acpi_has_method(dev->handle, "_SUN"))
> > >  		device_remove_file(&dev->dev, &dev_attr_sun);
> > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > index 6d3448895382..1cb39c5360cf 100644
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -145,6 +145,7 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
> > >  	struct acpi_device_physical_node *pn;
> > >  	bool second_pass = (bool)data;
> > >  	acpi_status status = AE_OK;
> > > +	char *envp[] = { "EVENT=offline", NULL };
> > >  
> > >  	if (acpi_bus_get_device(handle, &device))
> > >  		return AE_OK;
> > > @@ -166,7 +167,18 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
> > >  		} else {
> > >  			pn->put_online = false;
> > >  		}
> > > -		ret = device_offline(pn->dev);
> > > +
> > > +		/* Don't offline directly but need to notify userland first */
> > > +		if (device->request_offline) {
> > > +			if (pn->dev->offline)
> > > +				ret = 0;
> > > +			else
> > > +				ret = kobject_uevent_env(&pn->dev->kobj,
> > > +							KOBJ_CHANGE, envp);
> > 
> > So this is a userspace visable change with regards to kobject events?
> > 
> > Are you sure that is ok?
> > 
> 
> Since udev can see kobject events when devices are added, I haven't seen any
> risk if we make offline events visible too. Besides, normally online/eject
> attributes can only be written by root in userspace.
> 
Correct my explanation here: So far udev can see several device events already,
such as add, online, offline and remove. So I think it should not be risky if
we send additional change events to userspace as notification.

> Thanks,
> Chester Lin
