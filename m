Return-Path: <linux-acpi+bounces-6303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E7903DC7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A61C232D7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F517CA1D;
	Tue, 11 Jun 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WizT/dsh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96817D344;
	Tue, 11 Jun 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113301; cv=fail; b=bo5C4H5t8Ryb7KA6cReiftGZDl+v7M9KCha8WjJXlPZn+0r1OPjGqaGwpYbNiNa8cJMf2fTmZH4xzqT3DZJZyHuTkNiFaWxBEoA3i+Erfl9MML84uPoYtXyiq9/AgJ9QZNu8MjsyC3mZ0qagIhmHxHTeVbOzH7N3t/PgFQdFPG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113301; c=relaxed/simple;
	bh=YOqEXew9IU5NLHqJ0l1aB2ilEfBejK5cTtsNXnjal5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q0HAUya9BbHf+QlAn0e+IAxra8ZdRorqtfDUPZ1kadYyonwyaaNo36wGwT/gDpE7csJ/HKmIjSHruEj/GxJeJ5wXuVmNnj68CMNHj8YmkknCNnwY5GH7qXBAlOmL041jRp9IQwbhuk0a/BAx+2+Kp+JYcuW3Cjk9kyIl4qMRMTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WizT/dsh; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW3tDCyu7u9Wh2kD/4Cq9NE+LKZKBZBCC/GDToxZtvVYXmpsmzctiVauJC/+RIPleJ/NKBA+4cWwra25YUV5pHcPNXaukXK3Y7Gmiu2emIq1cJgkLGP5O/AlT4/pnd/VrBd4tb1fSHx5wkvVIlidxoAQepvvtpXHT8WH8RQJXcUGIRQRP5dsUwVPNrGBrL8YRbtheftQjrttHHXXo/XAA+zx1Zok/Tn1ouD1pyw1wSlDht+ej1iMrPNt/ru3TX+AkwoP5R/zGCfgKJoaET7k+Bmuc7Yr1H/y4zYuRG2OVL9iD/gobzc6Woarm2iwb5U3dVypWwBODxL99y8XkIOVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOqEXew9IU5NLHqJ0l1aB2ilEfBejK5cTtsNXnjal5w=;
 b=h3ELEptDWGDcRvXpEiRjXxP+vF7ySJkiqpJEVw2rBdREwHyPmXsaHVD3Brc6IvibTzvbJcl922HnOuaww7QrCx6vHk6dAhqef1llBcqhfceyseLL9gOV0P6ahk5he7lEkwFD4wTFeNvHjYIJFhUDf+R2wYESpL4Qytg3PEeMCWiAsLdWTX660nRLfaVgGhR0ztlqK5lKn0RU9/IlsUkk7P7tAft5dd7aQ70C+igNzgpyfOuUUFkxordeVUeRuf3h+SGfcXN+6+K/zHezjRySp7V7TDSlXpax5OuSPKYei0HyQLezX1989muiFVVSaHDIDaDk5OM7dv59wfRERC/Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOqEXew9IU5NLHqJ0l1aB2ilEfBejK5cTtsNXnjal5w=;
 b=WizT/dshPAhUXeM7/NeIwm9brUMFuWe6TexyNMH2AYQugyGVbYjQU3fqxECGTpUaaSK1qZ8otpaCpAmyGM81V2wXttyh41nnBAnsOGT9tt/Hh6LEg+vd9LI9yJBByRZNRt7TVfytQVL+34hNvNKbFw3nNMyzviOyM1pbFcrgeiudWZdfw1Z+Y/rhbvGl6snAhURzG8yuLKaJ08vyu/fPQVZIf0VptVHyMNmGcAXOJYKvw/CqRHOUSeDaIU6Br7SJDXUh350xg40CqAhDJ5aPKt3ER1JbJZPcHY+hM2/9p08fBeUNKv/FH1uKNFPTIbOVlt95zJriBoYnPnCVf4JAqg==
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 13:41:33 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:41:32 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful shutdown
Thread-Topic: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful
 shutdown
Thread-Index: AQHamnYypS12Ry633E+vgoPCPytAfrG6FhwAgAi7v+A=
Date: Tue, 11 Jun 2024 13:41:32 +0000
Message-ID:
 <PH7PR12MB728282B2D097CC45F8CCD88DD7C72@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20240429204519.1618-1-asmaa@nvidia.com>
 <j6nkeh6wyonjuwfznhanfx7i6tpxaxr2tlxami3punkukoslnx@l7w73vgebguw>
In-Reply-To: <j6nkeh6wyonjuwfznhanfx7i6tpxaxr2tlxami3punkukoslnx@l7w73vgebguw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7282:EE_|DS0PR12MB6581:EE_
x-ms-office365-filtering-correlation-id: 9800d880-c0de-4a6e-d385-08dc8a1c34bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OnsHIOlyYyMnC3D0tkpBI5WNU8griHQmmrTlyLPopRnBWgIJAmSEC1UXFHNR?=
 =?us-ascii?Q?8U5BeO/jI2GfiXz72ckEiD8IM+JbmP6zvBdhN+GH5o17coDfMe/ntWps7FoB?=
 =?us-ascii?Q?+RFvKTnHfm+EZjZ7qX8OItRSdRbKF9FMaPxkMKNxf1d5kfU5tImPpXDl8tS7?=
 =?us-ascii?Q?0BcZblXU8nAtqDeSFqka6bo4Qe/IGb9XXMFIpwsQzz3l8t81PvJ85YWRPANv?=
 =?us-ascii?Q?UjbsFGBN5RieCQ09STyh1WAmskKGi4n2Rx21l23ACcUhpA9OCU996ln59Hg0?=
 =?us-ascii?Q?KzhiKx/39jwOpBAefLpFCKJVl3IxqwpwhOlhlz07ewrb8i9hslVybLc9MRiz?=
 =?us-ascii?Q?OYXFrEAJp6a0bS9/P2JDKw2rfxLp32zZ5MH4F7pjEXpLyKbPXnUXsx8E5mzj?=
 =?us-ascii?Q?Rh+DmVTm0es8R/h5baoTuPNooWGkMfBbbdfSh18XJziF4coHkIc0zcIIPKBq?=
 =?us-ascii?Q?Fjtud6jiOHkdKTgsEttT7KT4l9NtaoB4a7dX7C9BXEgXl7254R6OEii/5wKa?=
 =?us-ascii?Q?LPW+4O3BdksAcqYR+Oo9YlbkWn3IEcjtEeqxuwD/gXIs10Vv5aABIsJGFO8w?=
 =?us-ascii?Q?eS3W2VH0CcrSOZbp0tDEt/gBXikkpvNVqOYVgLjYltb6B9ArftHSQdFtQQen?=
 =?us-ascii?Q?oY44MiB24roF2BVFMt3Rpw0VBX9tfi78l9RXZHcYgrlh3HismUTWcmpO/aXb?=
 =?us-ascii?Q?to/t10ttn+A1IZW3cEgs213nhDqMHWVbQxL+ZTVaxDGpWEwIVVZPtsQhAu2S?=
 =?us-ascii?Q?PtIDeKOOgvmKPRYBuHhT19O2jCFn2efgJyCnVmDgF5tYJ9FG7sJ4eFVV0omL?=
 =?us-ascii?Q?SF6TsZkPxCYLBhjaqekbm29MA10gtMqczKNPZc9qXkVwRRMGod5ZESrXiH6O?=
 =?us-ascii?Q?m4MY7GuA4YBmQW02i6F80hZ+Fm6sxjXedm9iy7CwNpC7wvpdNgQOfBZhQPqf?=
 =?us-ascii?Q?yBxxPn3gtsFSgzlOtLQzuzqqSyVUrSfMe2zzN1ai7gxkDTj+0sjRPowrbQzN?=
 =?us-ascii?Q?bW6lmBA1Ri6KGRAILwDcjW4NLEe4pqN7N6bvAgD8zKDFlUOkxGZSdISkMIvR?=
 =?us-ascii?Q?VIRYLkrG62h9gd9GxY8TkgCpyckOYtaosyockTuiRhXNIlJY+ePZSn4h1/Am?=
 =?us-ascii?Q?FsATjRzRE7cuJh8D42GbOSZXXbHqgocEBrm0DnrAZw6s5cqZW7xDXpvdiA22?=
 =?us-ascii?Q?qrw/MvBxoJRWlQQsKc6KHzTpLtromvnFyeweJcpYuqWi90AGfLizL/GbINZ7?=
 =?us-ascii?Q?GME1D8bHG0JWM4y8Yg8S5/UnYtsWdDyVPQZXnh08EMSwj89ItFZYPvW2oXVh?=
 =?us-ascii?Q?eWSWpRy2lstr9tqkdt7fNiSNdj1/gAH/mOmWNF+hK9GhCs4WLxPCWxsQQALi?=
 =?us-ascii?Q?2ASdSx8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qPkzzetZ9WlHIGsLlKT04eMVxtlW8eZ8fBMNGlMdV6s+5PGG2UGU9KqjTyhQ?=
 =?us-ascii?Q?dGrEA24I9wxvdjVnOFKvNVU/n7VOv4R2c/C0doQykkp6QkFGBQSE34Bbd7sY?=
 =?us-ascii?Q?lQrRdqysfAHmxesk2QTU4vRd5P8Ir/pWeeJBr71+FXcAlF13t7jVq14tItb0?=
 =?us-ascii?Q?V/dHaDvugqeLulZNHZdwelZ/c1i9z6YF0i3aHZS9rGb+DTKcOcydnJ2MrxYp?=
 =?us-ascii?Q?kDZB2UwFCKF5g1HEdM2zgOy9AoiDzRFwF2kcMm/jIFvKrYwBJKmEldH+OT9J?=
 =?us-ascii?Q?l3GhmAbFyiw2iqi5O+LROjFYuOkr4qCZLJrbzTKTe+H7UIU4DTMwF0lfJm4G?=
 =?us-ascii?Q?884IIvgXmUW9QQBoCRX+oZakv//IcyWlEYcKQRAM2zDzhVQYkqJ41oKzikQ9?=
 =?us-ascii?Q?h+jLKsbzBel+78qEWX/YS2gLf9qyeUmL5gJ2mxlydkWFVdhX+51HKmD1dIEm?=
 =?us-ascii?Q?0XYr4pQg09g8m6sNnFv0AkcE57sQjLFUKZvpIBEHoJvpZScgOcSc8+h4Mgr8?=
 =?us-ascii?Q?je2vaJ7mx1vPvfPua73dkB2YtWq7k821W6gcOg4Oo/WyJLSxUpXBFZfsI3fH?=
 =?us-ascii?Q?c2y3rqPK42JItcoVEujVRwlVPAGyBiBoeN2b5U9d5iDboN+/h+xYzx1FMWLQ?=
 =?us-ascii?Q?Vx2dKsFd1xVFi1TmScsj5fl/KPKbbRdqABaOPLNEob3eEhOVzX82J1t0L6ck?=
 =?us-ascii?Q?2BAKbpBapGluSbqXcozPLSfVEzk905xPxyI6sU4vfiPUyY62cM6PQZIHN/pR?=
 =?us-ascii?Q?ARou2z55KxhX1cgpLPXO2csoG8Q8tOlwxh2FNm7kCicyoTtdxasAXw5wUNOL?=
 =?us-ascii?Q?dtbSCuVELZ1vgG/FUXlLRhInbUzxW6YD35/XaHUpSy7JhVnbvIxwDYxfjq+F?=
 =?us-ascii?Q?+Bdic7FJ3HIzeH3PC5P/DRvojZ/tx8wTqbpMmhaBp8ppBisG96eJZUxmABvp?=
 =?us-ascii?Q?MwcbsIwFp7J9P6Hp6Zv/nPFPSClfmHkLPnF3SCi+m0GuB0aT4hKSvu0XgdLX?=
 =?us-ascii?Q?jjGJNNXklPXfbrm8q292MR0z0By3SBEb3hBYWg1NeUzOG5G6zTaPQTJzn1xI?=
 =?us-ascii?Q?bBfYIqxqorSdOVCdkWFdZ7BIUg36T8Zs1JnBDt6hzD/6BjzE3zfSC9XmEwzO?=
 =?us-ascii?Q?9Kvo4wKczLcxH9Z6IoHdUspbGsYmovI1vPuGvEcunaMuHvsK6Rp6nOeUe5ID?=
 =?us-ascii?Q?ShelyKKhZodGhAqHfukg8UFA3Xy+WVXV1Fhqla+lFidTlh6d+wPWTBOOwAJf?=
 =?us-ascii?Q?FxZjnWGgT5316Ni1TD0Kd7FMQG/1k3dwornPX4L49R/AClbMm6l0woZOXvqE?=
 =?us-ascii?Q?PIlFfk8O8Wkne5LpxBjsnft1Wjuag77zqhBwgK4W85ptVUZ34dCozLeHisQo?=
 =?us-ascii?Q?uA9OdfE0wukcPZXZZ6bAwb+yrDypuyqLv3yiVdo2I9Q8Javf55Zx/rwkL4iy?=
 =?us-ascii?Q?vtM1ZjYgpPfR3pEt9/iuwB2IJ/uFFVQQkOH2ipxNpcfZ5RzWhZO/T+doBn8m?=
 =?us-ascii?Q?eLyBp1UDKphGTL8g3N7cS4bwQHaM40kS6zbiiZWKEhjhsuD7s/omWDoK6w+D?=
 =?us-ascii?Q?rABG54cAgR0tAsbGKeM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9800d880-c0de-4a6e-d385-08dc8a1c34bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 13:41:32.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jVt9v1Wt/xgghFcJCvEoWGOKKD7yFtfxSsVkuEymSoF9ZCcGbBkIGvrhrvAM4aWpbQyLvX+EZnixx3hujLQXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581

Just sent a new patch with a description.

Thanks!
Asmaa

> -----Original Message-----
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> Sent: Wednesday, June 5, 2024 8:07 PM
> To: Asmaa Mnebhi <asmaa@nvidia.com>
> Cc: linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful
> shutdown
>=20
> Hi,
>=20
> On Mon, Apr 29, 2024 at 04:45:19PM -0400, Asmaa Mnebhi wrote:
> > Replace the low power mode with a graceful shutdown.
>=20
> That's a summary of what the code changes, but the commit description is
> missing an important information. It's not obvious why this change is nee=
ded.
> Especially considering the past of this driver: It started with
>=20
> reset =3D> emergency reset
> low power =3D> poweroff HID event
>=20
> Then got changed to
>=20
> reset =3D> reset HID event
> low power =3D> poweroff HID event
>=20
> And now is further changed to
>=20
> reset =3D> reset HID event
> low power =3D> emergency poweroff
>=20
> I don't think it's sensible to continue this ping pong, so please properl=
y
> describe what those IRQs are for and why further changes are needed.
>=20
> Greetings,
>=20
> -- Sebastian

