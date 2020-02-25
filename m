Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6216BE5D
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 11:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgBYKM4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 05:12:56 -0500
Received: from mail-am6eur05on2073.outbound.protection.outlook.com ([40.107.22.73]:21077
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729417AbgBYKM4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 05:12:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGzpA1Bvzm1ucJPIqMFOqb5Oqb5X9DX4d8aPnsZwBCsiuZSkyMcvgEtPF9B7EslfcWCTBZ97hJrXrA/BlzHY0v+4l7wnfqaf5d3Jb+5MZBoBhN7BKGiN2RYbWs94cBNXZMw98adwVFGS3iGcCXxKsYLp+pvLVlLEOAIch2P8NArGe1wZzA76qbCNr3Q4JpSdFfp79LYR4F/sc0fny+25YgkOslpwF7hH8MojTnyanYfZbJQdeWuyDBrCZgMUNfesRvJVk9IP8T+fr5MVuYuBx8LlAWmz5fTKodZzW/pOwA2Jx5iG+i9jXiBoRhnNdyFT4QaXxzq8Rvi00nJ0SMMxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdtSUpe3E2Cr8xKe9m8DP+L86eHa7sfyVNDQvwgdcSM=;
 b=d0pNRphqU0Xz6r5rDXejMqwKK05WCbBIGK/fbE2PZhAaowI5jJzGAa9fUBYQK5xwyCvvwRrxtom+fzjv8Rb2IQHehOSwPW3+BFrjRCfkCiegymAKUqcnBBFSAXhToCOE+BZlmLJaSPQav3CNaR4HjKKIS7vwlPS4MGZqIpO3ZnXzyW7RUfqB5kJLI/1cbQfxdL8gGe6cyRiFPHiRT11PJe+QjbCljf4m+oC6qCZIk9Aj/ZGLUZzN8XqpUGjd/4bDPUjNL86tdyC/hYlVYvkc8BBpsXMhy1RNe/Sy03kAK+nKoYV/f/mU8srEjcqyL7oMhpO9DKb9jvCI10u6Rkj+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdtSUpe3E2Cr8xKe9m8DP+L86eHa7sfyVNDQvwgdcSM=;
 b=hTHQTivQDsiTQYX1pY27rTMZ+gLzOJronDf8iMNeiWx9RX40gvBgokPPd1BDVngFMWV/SgqmwH1t2q7UPXxfZSSgEf53dpNdajvb8B3zIpl3C4w9qVQplORD+3QdxnfA7+muIL7wF42g1U+vtS0kNvDBGxOBHNvoRVE8vbccPJI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=calvin.johnson@oss.nxp.com; 
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) by
 AM0PR04MB6209.eurprd04.prod.outlook.com (20.179.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Tue, 25 Feb 2020 10:12:52 +0000
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::1b4:31d2:1485:6e07]) by AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::1b4:31d2:1485:6e07%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 10:12:52 +0000
Date:   Tue, 25 Feb 2020 15:42:40 +0530
From:   Calvin Johnson <calvin.johnson@oss.nxp.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux.cj@gmail.com" <linux.cj@gmail.com>,
        Jon Nettleton <jon@solid-run.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Rajesh V. Bikkina" <rajesh.bikkina@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [EXT] Re: [PATCH v1 1/7] mdio_bus: Introduce fwnode MDIO helpers
Message-ID: <20200225101240.GA8966@lsv03152.swis.in-blr01.nxp.com>
References: <20200131153440.20870-1-calvin.johnson@nxp.com>
 <20200131153440.20870-2-calvin.johnson@nxp.com>
 <371ff9b4-4de6-7a03-90f8-a1eae4d5402d@arm.com>
 <AM0PR04MB56366808BA5C841E4E7BC86E931C0@AM0PR04MB5636.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB56366808BA5C841E4E7BC86E931C0@AM0PR04MB5636.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To AM0PR04MB5636.eurprd04.prod.outlook.com (2603:10a6:208:130::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03152.swis.in-blr01.nxp.com (14.142.151.118) by SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 10:12:48 +0000
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 656a04a1-dde0-4c67-15c3-08d7b9db45b1
X-MS-TrafficTypeDiagnostic: AM0PR04MB6209:|AM0PR04MB6209:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6209215E76C21545207BEFA7D2ED0@AM0PR04MB6209.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(1076003)(16526019)(66556008)(66946007)(55016002)(186003)(6666004)(6506007)(55236004)(2906002)(1006002)(66476007)(9686003)(26005)(86362001)(5660300002)(956004)(316002)(81156014)(966005)(44832011)(8676002)(4326008)(7696005)(110136005)(8936002)(52116002)(81166006)(33656002)(478600001)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6209;H:AM0PR04MB5636.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pviDLN3JYNIFEnWNRgLCGKVWxBoZAoTKLRP9/maL5BOA1SqFyv8V+/371ZQ7uyOanpdi3VDKk4OvO9GsR0hvwbjDIQNOiHhFBerY+Y4fd6UXNMITj3VkEcFiDaa7Fph9RXZQLCWQW4fb3rrnEwpwctf81g0UVyphNVkWNZDRIk/nJwU+72/3BUZaLyUoG31UQZF7Bl843AMH/r6DNwBK8r7mFuGe99tsOCmCCVm/gGgB15tO58uIOlXT3pj3O3qOFEwEgy9DP9Ci3NqndrGXLkD68DvtFYYPbwLP0Ls9wvfGaO6TO8nJVqnceYB47JAW5e8MXRvnlaSn5KUCGdbVFVIZ0UCmGEpCXCrBqSTyf//V4P3tSWtfZNLVz/9Hp3rux1FD4PhzVmcdKS3LvENf0riEFNmj9bvZL1a06+bB45O5n8F/2K+41qmfMpQfz1EkpfGcKTEG1F9Pqp2Zo362E+hdOUqVH+M3tKF6gFTf6HLWBlRsaAfEH4ZYHrbWJ+tcIDh8zJoTLk3YViESWiH0D272RUqF4pnm8r9+T2sggVaesocmuPOmRwWTSCN7ZKTSlKBlfyxqSqC0bI9SDY/wDjLOoXyGDB6KTenalBNmY/E=
X-MS-Exchange-AntiSpam-MessageData: q+W45vjNI3hXhCKwFw2+pq1aWHhfqQm3PsZuZA2DurFjfz8wSQg4y16Lnz9D9CKTOx62MQp2/1YhVWf5yGNDlbzJO7TFdbCsD5/seUS+cPdzYRXEKjAF+cAte/Qio2rKeFUR+r8nXSmavxTTx/CXdA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656a04a1-dde0-4c67-15c3-08d7b9db45b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 10:12:51.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtzplJhigeAEs1PCNFAm3Wv9jrzRreDVdZ8ov2Ihti89pZW0pAsLH0PmIe56l8bviGBUXJrcmXzFDyZ9Mb/YUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6209
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 07, 2020 at 09:42:56AM +0000, Calvin Johnson (OSS) wrote:
Hi Jeremy,

 
> > -----Original Message-----
> > From: Jeremy Linton <jeremy.linton@arm.com>
> > Sent: Wednesday, February 5, 2020 7:48 PM
> 
> <snip>
> 
> > > +static int fwnode_mdio_parse_addr(struct device *dev,
> > > +                               const struct fwnode_handle *fwnode) {
> > > +     u32 addr;
> > > +     int ret;
> > > +
> > > +     ret = fwnode_property_read_u32(fwnode, "reg", &addr);
> > > +     if (ret < 0) {
> > > +             dev_err(dev, "PHY node has no 'reg' property\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     /* A PHY must have a reg property in the range [0-31] */
> > > +     if (addr < 0 || addr >= PHY_MAX_ADDR) {
> > > +             dev_err(dev, "PHY address %i is invalid\n", addr);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return addr;
> > > +}
> > 
> > Almost assuredly this is wrong, the _ADR method exists to identify a device
> > on its parent bus. The DT reg property shouldn't be used like this in an ACPI
> > enviroment.

In the ACPI environment, can we use _ADR to get the PHY device address
from the DSDT? Is there any function to get this value?
acpi_ut_evaluate_numeric_object is called from inside drivers/acpi/acpica.
However, I don't see any other driver outside drivers/acpi using _ADR to get
the address.

> > 
> > Further, there are a number of other dt bindings in this set that seem
> > inappropriate in common/shared ACPI code paths. That is because AFAIK the
> > _DSD methods are there to provide device implementation specific
> > behaviors, not as standardized methods for a generic classes of devices.
> > Its vaguly the equivlant of the "vendor,xxxx" properties in DT.
> > 
> > This has been a discussion point on/off for a while with any attempt to
> > publicly specify/standardize for all OS vendors what they might find encoded
> > in a DSD property. The few year old "WORK_IN_PROGRESS" link on the uefi
> > page has a few suggested ones
> > 
> > https://uefi.org/sites/default/files/resources/nic-request-v2.pdf

Having this as part of spec would be helpful.
Do you know who can help get this nic-request integrated into spec?

> > 
> > Anyway, the use of phy-handle with a reference to the phy device on a
> > shared MDIO is a techically workable solution to the problem brought up in
> > the RPI/ACPI thread as well. OTOH, it suffers from the use of DSD and at a
> > minimum should probably be added to the document linked above if its
> > found to be the best way to handle this. Although, in the common case of a
> > mdio bus, matching acpi described devices with their discovered
> > counterparts (note the device() defintion in the spec
> > 19.6.30) only to define DSD refrences is a bit overkill.
> > 
> > Put another way, while seemingly not nessiary if a bus can be probed, a
> > nic/device->mdio->phy can be described in the normal ACPI heirarchy with
> > only appropriatly nested CRS and ADR resources. Its the shared nature of the
> > MDIO bus that causes problems.

Were you able to take a look at the shared DSDT tables? Is this the ACPI hierarchy
with nested CRS and ADR resources which you mentioned above?

> https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platforms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/Mdio.asl?h=LX2160_UEFI_ACPI_EAR1
> https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platforms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/Mc.asl?h=LX2160_UEFI_ACPI_EAR1

Thanks
Calvin
