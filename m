Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31C21A3E2
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGIPjC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 11:39:02 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:5684
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbgGIPjB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jul 2020 11:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbiDuCcM8RbaaEd6HeUGBwYPu/LhmKvMu8wqxFowgo/y6iZsDROpgT1OdoP06d8QYu2Cbqm9941RjbejMTWdC9b4OUKBWsdv9g1YEQiyqmPz3IfSbzwrzKKWucdGX1tFikno1Xlu0t1R2agrK/NYHlzAUhOkF7wmH99BzSxKV6ArraEP8hZ3YUOO8E+it4LKjhkHLIJyTP4i4J3F0Z2TLVOG/HwkU2sqLxuusTxqykJY8V5nz/M5ExnJvNTY4GHOeWNlNnBLpDpxqOnjpj1bDwOvUNemzD4dphplgIgqStQSD5n5S6h1hnl+VcZHr1kLwCSKvLU0zID9zvsElYYy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgiIUBTYJic1QyvZ2OdAzJ9zzRqqPPjobQ+VttQtYCA=;
 b=NsSSu8+07QosHkzhTZVzuhLJiURNW2Qm3CDzfjNNV0ctq98mJYkxauHIMTZzHdrtY7riBnX4myCJ+Jo2JF/JqjyNHNkv65xdDNtjS6aDeS8BGE+0Maka7P8sBjTjxwiEgnHOY8uP3PZV8bJSxg1HEJIaAILO70mNChMghhn2Zc6j3OIbjGb4SEg8R/2PUDY3JRZOEuSTEq9TtP/jLUXPQazr9BHv4yAYTE53QWYfIvZqsJdimgSHF04BpqNVo5yxIXoCd3c0/wamrk/NuOIJOpUGOfDJI/7XKjqQnxAOgchkoiBHUeAmd5GMODs8O0TZmk6zgRvEyntcgGXTvE3y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgiIUBTYJic1QyvZ2OdAzJ9zzRqqPPjobQ+VttQtYCA=;
 b=hYAGZqEzUZYfZWr9yRLW8U4JnOfObQNqLjXSR5x0PL6pgHTnVc8zMpUOuFzPsjQtNKNnBcqxdPp4e7uL6HCz7xeAUT5eUozbLEcjkeMSM5F/H1vnOHJpfHBgMVRZ0GFAszDIYokXk0vXtsIBoDEQEBM+Am9cqzUVs2tajgeVL+Q=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0501MB2494.eurprd05.prod.outlook.com (2603:10a6:800:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 15:38:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 15:38:58 +0000
Date:   Thu, 9 Jul 2020 12:38:54 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
Message-ID: <20200709153854.GY23821@mellanox.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709150051.GA17342@infradead.org>
X-ClientProxiedBy: MN2PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:208:239::8) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 15:38:57 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jtYdS-007dM5-Ec; Thu, 09 Jul 2020 12:38:54 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af5f7a7c-4f35-4e3b-4de4-08d8241e31e7
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2494:
X-Microsoft-Antispam-PRVS: <VI1PR0501MB249425F6FCE3C20702820DC7CF640@VI1PR0501MB2494.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5BItQgEdUp/U57fAtkFTGtjZY70QqgOBjvgyyrgIin7NdwILXRTI0uUzbFREZUoavAb2uX/CXM83CzV9SIQcX6S3X5VUjQyJixqKTdyls5tJ35Ura+xPt9kgZzr2koOuVwhDYLKIO/rOA3uXNioScfcgz8ta82lN3OUuLMqdz7EYuuXf/sN/uvFcpZ0oGFDGTvnk82l4leM61iMsBy8C+gxWJVWjNiGQYLwAmPFAvRdH9BlR9qs87ST6hj3hRQWNv9dtgGJKVGxvF0RzTu81fpUoM+b4LlBW1781BAr+S/nodM/5CAgvmma6SEnXC0/fQDgsi8NDqNQbeYDmmo3FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(2906002)(186003)(36756003)(8936002)(6916009)(7416002)(316002)(54906003)(478600001)(86362001)(4326008)(8676002)(1076003)(2616005)(33656002)(26005)(9746002)(9786002)(5660300002)(66556008)(66946007)(66476007)(83380400001)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 41VY4oW5LCWMv1eRyfnIFMHXPJ0AiR8ofnbveUTWHfiduARBIbwUCTamkA3oDnALxp64MchI/HcnKN9lTcDbpQL02z8/7h/jU2+qX+8JeaD+LMWr0K3GZ+/35jlZP+aasoAsjj8B59wYHdv9grcPQk4gmMr8vnlM7HyNGjzIducyn576jxqokNDsxzzIN3bSi/ZPAczrATN7kv/b6Flr1SlJfiR5QJdq4kzR2uW/9QfMj812GqcRKlCE/Q6wgeVE0amNbBib0yKISvUvSpgOkObZN+b+u2+7pA2FO6NNk3iu84FmLr9Bsfg1yD+Przd8QGpMnDQ5rFGbu92aMJ2x/YOuOuS/9Mv12HB71W8TYAsft+uwQPqCXSdzC9ro0MwnX+yWgrfvYwLmx7mQUUWrgNa3DObWDv6/W+Cu2OYp1EF71S2eJiRAPeIAQqYEqOqO71CruK6iW+ePkrl3dmKZlLo+RFC5r5uo8zS1mjKGsvw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5f7a7c-4f35-4e3b-4de4-08d8241e31e7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:38:58.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYbYHTu5h+VFoRrobwRczlgtfjKTwyOMterIE7d1RTLKrDDvGZgplR26EKejiJK7E8Tf4weygPCOxLIwg/b7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2494
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 09, 2020 at 04:00:51PM +0100, Christoph Hellwig wrote:
> On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> > The runtime firmware activation capability of Intel NVDIMM devices
> > requires memory transactions to be disabled for 100s of microseconds.
> > This timeout is large enough to cause in-flight DMA to fail and other
> > application detectable timeouts. Arrange for firmware activation to be
> > executed while the system is "quiesced", all processes and device-DMA
> > frozen.
> > 
> > It is already required that invoking device ->freeze() callbacks is
> > sufficient to cease DMA. A device that continues memory writes outside
> > of user-direction violates expectations of the PM core to be to
> > establish a coherent hibernation image.
> > 
> > That said, RDMA devices are an example of a device that access memory
> > outside of user process direction.

Are you saying freeze doesn't work for some RDMA drivers? That would
be a driver bug, I think.

The consequences of doing freeze are pretty serious, but it should
still stop DMA.

Jason
