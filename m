Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0739812F6BD
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgACKa7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 3 Jan 2020 05:30:59 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:52076 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgACKa6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jan 2020 05:30:58 -0500
X-Greylist: delayed 21039 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2020 05:30:57 EST
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Fri,  3 Jan 2020 10:28:43 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 3 Jan 2020 10:28:37 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 3 Jan 2020 10:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKIdnN4iFks65LZdbE9ASvAGKM3u9YWWHWh75Y7uyPgu6T0ILS9B3jbRc1oCiJGaAQWkK4Bm82NzyYZcYssyZVm4q/ONGFzLw23pD3wKbWIkq7/6LgAhXb6HcqFLa3+AUpVVk5d1G5vz4Yf9IJ6gqrQp24r6shz59QA0BPgVeNqgrmQRpISYLhsbGZjy4rDEp+n7+xFLnt0mTybRilOtW81bOw0SR1mJs59saErxNEH7TBX7UEuVHXLJsfqh78Ij3P3EnRfRKqrwxXf02sVW10koQ1TEIOP4zIN1Uy/+FCmIh9htX1CuD7NBCMXhrKaWt1wVSPiZ9Wfi6Q4MrTgnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnDAy0QYr9hQLhshBVuVzD2KNbmU7LKNkb0FxBAuqeM=;
 b=PkseEmQXNNq/B4zT8Ykc8y9W8DbZx5DH3utVe7dlvjKFoivDN3JEGSRnra5wYOLLGZfuNDoBs6IoGCvHLLo8jp4+Y/h9R33+9YXR9ybmG2LHrl4zAVdeeKZsr4iPh9vwiC2ASdKfvlPfZiax6WV50X8Bd75kdLFlFlfuNh52qJNuAzFKqoHVsTRTpqvbQFjikdxXqJxgXq4XdB6FqpZyZz+3281PwR406AXsalU6u/M6zneAuW4BM8JUXIfPoD04ewecaYodDb1y3msMbAS7cmwST+Yog7Xm6MK80UuT8bTvDMcPDABI7+IpnT2Zo+cLSPequxVRkzPe303xRArrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (52.132.196.157) by
 SN1PR18MB2158.namprd18.prod.outlook.com (52.132.200.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 10:28:35 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 10:28:35 +0000
Received: from linux-8mug (60.251.47.115) by HK2PR03CA0047.apcprd03.prod.outlook.com (2603:1096:202:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Fri, 3 Jan 2020 10:28:33 +0000
From:   Chester Lin <clin@suse.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] ACPI / device_sysfs: Add eject_show and add a
 cancel option in eject_store
Thread-Topic: [RFC PATCH v2 3/3] ACPI / device_sysfs: Add eject_show and add a
 cancel option in eject_store
Thread-Index: AQHVwe/laTkHKyiaX0KG+ALRD+NasKfYnjAAgAAe/AA=
Date:   Fri, 3 Jan 2020 10:28:35 +0000
Message-ID: <20200103102822.GA7077@linux-8mug>
References: <20200103043926.31507-1-clin@suse.com>
 <20200103043926.31507-4-clin@suse.com> <20200103083728.GB831558@kroah.com>
In-Reply-To: <20200103083728.GB831558@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:202:17::17) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [60.251.47.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75ae4eae-3e40-4d12-c22e-08d79037b089
x-ms-traffictypediagnostic: SN1PR18MB2158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR18MB2158D61020B40D08F45B56F0AD230@SN1PR18MB2158.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(52314003)(45074003)(189003)(199004)(71200400001)(86362001)(55016002)(26005)(55236004)(6916009)(478600001)(4326008)(956004)(8936002)(81166006)(81156014)(52116002)(66946007)(66476007)(66556008)(64756008)(66446008)(33716001)(1076003)(33656002)(8676002)(9686003)(5660300002)(2906002)(16526019)(186003)(316002)(6496006)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2158;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4vRc8LXhmAokBALF+Djclfndiv0zCrUEbPIs6HEuY2jtueBpGimX830Z7P9iRJnJ5IBbzcO0oVSl1jNFFUzZQmFc8BxhmDD2vq6lpfDBLZbSasbOv1FjNgYbPkN/46IbaDBHrlUp6+aAwbNgD/BLrkjfBQ+gZFeb6E+l+itnOp+0A9fO46PZP0fB9/lnlTiw+ADSMvRBcpHRrqKenbZMmdsb2dMhpMmj7QS6JBUe+S08+W0nMi1HIfsua5vWS1BWTAmlmDAOgAvGmCRYOkiV6H8TwOT2/hPL/Cg2TSRIazC+RnEH9N4AAIegZ65pUx5Egjr0Hjms1zS3pvfDmx1MIo3aYl255R36ubS80XKrZ7z35Kia6Gyn06VNyGdvJmEM7NY//e1J97NAQ7xDXxIvoTHGVqznZnKreAbIgxrMfNNCCcAjkDm5q4BKADmz9Xe/LTqtXc8D9v1lSis8bBfiDRpE4xkAItQWMhrEzNoxqopJBC5IhUSRu6leolfLdge8AXhvza5NNVVSrj2pRno+w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9F93DDF40405E4D82A57E1A67515C1D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ae4eae-3e40-4d12-c22e-08d79037b089
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 10:28:35.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rW0Jh4SOVkG8P90n3gYCe2osGL17PUmYgvwjmAEMEANvowWwU0RCu/RFXJ3BRtEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2158
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Greg,

On Fri, Jan 03, 2020 at 09:37:28AM +0100, gregkh@linuxfoundation.org wrote:
> On Fri, Jan 03, 2020 at 04:40:17AM +0000, Chester Lin wrote:
> > Add an eject_show attribute for users to monitor current status because
> > sometimes it could take time to finish an ejection so we need to know
> > whether it is still in progress or not. For userspace who might need to
> > cancel an onging ejection, we also offer an option in eject_store.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-acpi |  9 ++-
> >  drivers/acpi/device_sysfs.c              | 94 +++++++++++++++++++++---
> >  drivers/acpi/internal.h                  |  4 +-
> >  drivers/acpi/scan.c                      | 38 +++++++++-
> >  4 files changed, 129 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> > index e7898cfe5fb1..32fdf4af962e 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > @@ -53,9 +53,12 @@ What:		/sys/bus/acpi/devices/.../eject
> >  Date:		December 2006
> >  Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> >  Description:
> > -		Writing 1 to this attribute will trigger hot removal of
> > -		this device object.  This file exists for every device
> > -		object that has _EJ0 method.
> > +		(R) Allows users to read eject status of the device object.
> > +		(W) Writing 1 to this attribute will trigger hot removal of
> > +		this device object. Writing 2 to this attribute will cancel hot
> > +		removal work if it's still in offline process and the original
> > +		state of this device object will be recovered. This file exists
> > +		for every device object that has _EJ0 method.
> 
> Oh that's going to cause problems :)
> 
> Why not just have a new file, "cancel_eject" that you can write to, to
> cancel the eject happening?
> 
> That way you don't have an odd "state" that this file needs to keep
> track of.
> 

Thank you for the advice and I will add it.

> And what happens if you write a '2' here when eject is not happening?
> It didn't look like your code handled that state well.
>

When eject is not happening, the eject_stat is null so the procedure will go to
eject_end without changing anything.

> >  
> >  What:		/sys/bus/acpi/devices/.../status
> >  Date:		Jan, 2014
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 96869f1538b9..6801b268fe9d 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -365,17 +365,13 @@ static ssize_t power_state_show(struct device *dev,
> >  
> >  static DEVICE_ATTR_RO(power_state);
> >  
> > -static ssize_t
> > -acpi_eject_store(struct device *d, struct device_attribute *attr,
> > -		const char *buf, size_t count)
> > +static ssize_t eject_show(struct device *d,
> > +				struct device_attribute *attr, char *buf)
> >  {
> >  	struct acpi_device *acpi_device = to_acpi_device(d);
> >  	acpi_object_type not_used;
> >  	acpi_status status;
> >  
> > -	if (!count || buf[0] != '1')
> > -		return -EINVAL;
> > -
> >  	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
> >  	    && !acpi_device->driver)
> >  		return -ENODEV;
> > @@ -384,18 +380,96 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
> >  	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
> >  		return -ENODEV;
> >  
> > +	return sprintf(buf, "%s\n", acpi_eject_status_string(acpi_device));
> > +}
> > +
> > +static ssize_t
> > +eject_store(struct device *d, struct device_attribute *attr,
> > +		const char *buf, size_t count)
> > +{
> > +	struct acpi_device *acpi_device = to_acpi_device(d);
> > +	struct eject_data *eject_node = NULL;
> > +	acpi_object_type not_used;
> > +	acpi_status status;
> > +	bool cancel_eject = false;
> > +	ssize_t ret;
> > +
> > +	if (!count)
> > +		return -EINVAL;
> > +
> > +	switch (buf[0]) {
> > +	case '1':
> > +		break;
> > +	case '2':
> > +		acpi_scan_lock_acquire();
> > +		eject_node = (struct eject_data *)acpi_device->eject_stat;
> > +
> > +		if (!eject_node) {
> > +			acpi_scan_lock_release();
> > +			ret = -EINVAL;
> > +			goto eject_end;
> > +		}
> > +
> > +		/*
> > +		 * Find a root to start cancellation from the top
> > +		 */
> > +		if (eject_node->base.root_handle) {
> > +			acpi_device = acpi_bus_get_acpi_device(
> > +					eject_node->base.root_handle);
> > +
> > +			if (acpi_device)
> > +				eject_node =
> > +				   (struct eject_data *)acpi_device->eject_stat;
> > +			else
> > +				eject_node = NULL;
> > +
> > +		}
> > +
> > +		if (eject_node &&
> > +		   (eject_node->status == ACPI_EJECT_STATUS_GOING_OFFLINE ||
> > +		    eject_node->status == ACPI_EJECT_STATUS_READY_REMOVE)) {
> > +			eject_node->status = ACPI_EJECT_STATUS_CANCEL;
> > +			cancel_eject = true;
> > +		}
> > +
> > +		acpi_scan_lock_release();
> > +		if (cancel_eject)
> > +			break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto eject_end;
> > +	};
> > +
> > +	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
> > +	    && !acpi_device->driver) {
> > +		ret = -ENODEV;
> > +		goto eject_end;
> > +	}
> > +
> > +	status = acpi_get_type(acpi_device->handle, &not_used);
> > +	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable) {
> > +		ret = -ENODEV;
> > +		goto eject_end;
> > +	}
> > +
> >  	get_device(&acpi_device->dev);
> >  	status = acpi_hotplug_schedule(acpi_device, ACPI_OST_EC_OSPM_EJECT);
> > -	if (ACPI_SUCCESS(status))
> > -		return count;
> > +	if (ACPI_SUCCESS(status)) {
> > +		ret = count;
> > +		goto eject_end;
> > +	}
> >  
> >  	put_device(&acpi_device->dev);
> >  	acpi_evaluate_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
> >  			  ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
> > -	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
> > +	ret = (status == AE_NO_MEMORY) ? -ENOMEM : -EAGAIN;
> > +
> > +eject_end:
> > +	return ret;
> > +
> >  }
> >  
> > -static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
> > +static DEVICE_ATTR_RW(eject);
> >  
> >  static ssize_t
> >  acpi_device_hid_show(struct device *dev, struct device_attribute *attr, char *buf)
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index 8154690b872b..e5d526402188 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -265,7 +265,8 @@ enum acpi_eject_status {
> >  	ACPI_EJECT_STATUS_NONE = 0,
> >  	ACPI_EJECT_STATUS_GOING_OFFLINE,
> >  	ACPI_EJECT_STATUS_READY_REMOVE,
> > -	ACPI_EJECT_STATUS_FAIL
> > +	ACPI_EJECT_STATUS_FAIL,
> > +	ACPI_EJECT_STATUS_CANCEL
> >  };
> >  
> >  enum acpi_eject_node_type {
> > @@ -286,5 +287,6 @@ struct eject_data {
> >  };
> >  
> >  void acpi_eject_retry(struct acpi_device *adev);
> > +char *acpi_eject_status_string(struct acpi_device *adev);
> >  
> >  #endif /* _ACPI_INTERNAL_H_ */
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 13f16b6ad7a2..90983c067410 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -366,8 +366,9 @@ static int acpi_scan_offline_check(struct acpi_device *device)
> >  			return -EBUSY;
> >  		}
> >  
> > -		if (eject_obj->status == ACPI_EJECT_STATUS_FAIL) {
> > -			dev_warn(&device->dev, "Eject failed. Recover all.\n");
> > +		if (eject_obj->status == ACPI_EJECT_STATUS_FAIL ||
> > +		    eject_obj->status == ACPI_EJECT_STATUS_CANCEL) {
> > +			dev_warn(&device->dev, "Eject stopped. Recover all.\n");
> >  			acpi_scan_notify_online(device);
> >  			return -EAGAIN;
> >  		}
> > @@ -383,6 +384,39 @@ static int acpi_scan_offline_check(struct acpi_device *device)
> >  	return ret;
> >  }
> >  
> > +char *acpi_eject_status_string(struct acpi_device *adev)
> > +{
> > +	struct eject_data *eject_obj;
> > +	char *status_string = "none";
> > +
> > +	mutex_lock(&acpi_scan_lock);
> > +	eject_obj = (struct eject_data *) adev->eject_stat;
> 
> Always use checkpatch.pl so maintainers don't have to ask you to use
> checkpatch.pl :)
> 

Acutally I have used checkpatch.pl but haven't found a warning on this
line:
  total: 0 errors, 0 warnings, 199 lines checked

The last commit of checkpatch.pl in my code base is 184b8f7f91ca. Anyway,
thank you for the reminder I will remove the cast from next version :)

> > +
> > +	if (eject_obj) {
> > +		switch (eject_obj->status) {
> > +		case ACPI_EJECT_STATUS_NONE:
> > +			break;
> > +		case ACPI_EJECT_STATUS_GOING_OFFLINE:
> > +			status_string = "going offline";
> > +			break;
> > +		case ACPI_EJECT_STATUS_READY_REMOVE:
> > +			status_string = "ready to remove";
> > +			break;
> > +		case ACPI_EJECT_STATUS_FAIL:
> > +			status_string = "failure";
> > +			break;
> > +		case ACPI_EJECT_STATUS_CANCEL:
> > +			status_string = "cancel";
> > +			break;
> > +		default:
> > +			status_string = "(unknown)";
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&acpi_scan_lock);
> > +	return status_string;
> 
> So the state can change right after checking it and reporting it to
> userspace?
> 
> If so, what good is the lock here at all?
> 

I use this lock to prevent the eject_state from being freed during a query
since any status change might still happen. For example, the userland process
could be preempted before accessing eject_state and then the eject_state could
be quickly freed due to eject failure or eject completion. [The free opertion
is implemented in acpi_free_eject_stat()]

> 
> thanks,
> 
> greg k-h
> 
