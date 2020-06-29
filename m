Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1026620DFF5
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jun 2020 23:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbgF2UlY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Jun 2020 16:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbgF2TOG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2020 15:14:06 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02on061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe07::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575FC0068C0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2020 04:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/61uFHaZNd7buVOTiAOjB9BjRyK2aKf3qYdwyzFCN1GZgxoR/N9FT6ROp09W4/MOCEnfA9JF1DKemLiCfYGP4/CXU1LAUI92QV3IKACLtryx2RX3NxeZA1rQN3ho6vWq/MGy10DFvk5jzB4xqMv869X/jysmPlTVBycOwJUPTOHQWJdgdas0XwhjET4y5QAhoGOCV09StULnMe43vtBjGqRTf1ZvSRxBQylmozO57OCjaEn4nXnduq1g9QguY9xK1qW0hQMzR09UKyfMxM3Dfm9p5vkVY687aj+4uKcv2dMMX9jr/QUjMdL6QQ0PvP+OtpiPu/CGlev3XkLRZzjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc5qHEZr4Hpr0QmzWkCEr9dSiS9/vV6OIUbtKxPyZ88=;
 b=FX23w/dx10uYUCbirKxsisTidsEvI3+KECzh8UIuSqJh7HGVxwwz8MNUqRawx/hsS7Z/qUCl+3izTCcB4JR4koNkFFrLGurChitNqsPqAgOhENi/mw3E3L5E1jr3ZGqhLRP7PNYqnLuMZkooHVi4HVxSMfcJ53qXsa8cElRssyHR3qw49hwg8zB4N7tBQnsgAdJSCLVeLRS2g14H7D8ah+0HHtLXZ67IeI3Ydu9tW+dzYoXJ8T4kqrrWYQPxQ1w5HPM9u/DJmElIapblDoCACj7Ar7PuJiYeNsgc8OrgVoOnI3W06jm2Lanep2y+cOIj7RhJDsMiBXtli3PBkhHHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc5qHEZr4Hpr0QmzWkCEr9dSiS9/vV6OIUbtKxPyZ88=;
 b=M+krqowUM46noZ4PVM+zMmpl2SZvbPTlLOjKwZv0of/RQGfMLhPBPg+OTh/th8V0qGknEXbk4iLHZqaRGaBa/Oa7zQmvxplkWa1wwyEjPxoOW/xvrle2TFaiQne4FSRKEVzJkzpKL2Qjpa563CEDpet4Q7UCZJTrmfhU6aWSmIs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com (2603:10a6:208:130::22)
 by AM0PR04MB6210.eurprd04.prod.outlook.com (2603:10a6:208:13b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 11:40:39 +0000
Received: from AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::7dda:a30:6b25:4d45]) by AM0PR04MB5636.eurprd04.prod.outlook.com
 ([fe80::7dda:a30:6b25:4d45%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 11:40:39 +0000
Date:   Mon, 29 Jun 2020 17:10:27 +0530
From:   Calvin Johnson <calvin.johnson@oss.nxp.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jon <jon@solid-run.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [net-next PATCH v1] net: dpaa2-mac: Add ACPI support for DPAA2
 MAC driver
Message-ID: <20200629114027.GA18166@lsv03152.swis.in-blr01.nxp.com>
References: <20200625043538.25464-1-calvin.johnson@oss.nxp.com>
 <202006251802.jt5kabG7%lkp@intel.com>
 <CAHp75VcQwLwE1GMh+2Ht7p=Xa20mkTdGC2vt=bwNrr=G6SV1zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcQwLwE1GMh+2Ht7p=Xa20mkTdGC2vt=bwNrr=G6SV1zg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SG2PR06CA0118.apcprd06.prod.outlook.com
 (2603:1096:1:1d::20) To AM0PR04MB5636.eurprd04.prod.outlook.com
 (2603:10a6:208:130::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03152.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR06CA0118.apcprd06.prod.outlook.com (2603:1096:1:1d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 11:40:34 +0000
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02fd6ded-7eb4-4fb1-be52-08d81c213e3c
X-MS-TrafficTypeDiagnostic: AM0PR04MB6210:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6210CB17A1E2B1191876C855D26E0@AM0PR04MB6210.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7F7TeY7GAFDOwEwoY/pbcNyCfbrzt0eYV3bFQjE51kLQITRW7AhuRpsmqX0PtNSsTk30G5pxqr+SuGhOunpcQ52T3cQGrMUZKOhXj6rnyn7I1W/GlmJtqJ4UwJmAZiAiztmto1Wz8Y5aw1fokgfWZS2O1kW7qfZUVvN9t3y0xjsOnQ2o6Q1z0l6hDg9gpAXc3bN0NQgVmsL0fsd4WCyytyIXHzvlXfe5xbIfDwy8Y0Z47kNAMYvA/8wU7y086ta7wtuCUvT5swKsq9kRfWEFRdWsr8O77Q6gjzK/rBJy3X2bjAk4y7N7ktQfe6Op3O/c0NMV0aDZQRR045OaAMtmYnxzYAaq2TEzJ/knrqwmOct3F8sHWYYGhU3ZphpKjRMG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(54906003)(8676002)(5660300002)(6506007)(8936002)(55236004)(53546011)(83380400001)(86362001)(1076003)(4744005)(16526019)(186003)(1006002)(6666004)(66946007)(4326008)(2906002)(66476007)(44832011)(33656002)(26005)(956004)(66556008)(478600001)(316002)(6916009)(55016002)(9686003)(7696005)(52116002)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FKQZadoqFqHi5Cbu2SBw0iNbs58BgUeU/n4Q0Nw6OUK0widRWFXlbK/BodRoHzUBnPWsH5wUj6XrbUpkrwyZXK5Lc6oUOLw+FWcOO0hf4PW5JppooPyr4E7pbUgbe8vFDwciofNc3gvCUDmoVeTAbBbVvyLB8zhNC/gAh8Lqo5l3ftJnoxpceFFxQAVvDBQ2RI9iEI/qfOmUGBaHjLlnsUdvHd6vmX5I2+6PWywaDJuVTSaICGDjP3+zAH4rmSQt5cLjh3/fV5uBUv5//A4pJhBDM3NrHIl4tInyT4PuCXeHmALwekwF3thZ328AIbeBv2GWVONquCv5LkS/mJVUX2a6TZuz4uw5O87cfpOGnYCAEgYEqclRuFTY8fdfgyyHg4UcB5K9MHhVU9cnkC8kWryKF+u1a5+ig6BiQ1gUViIL0u2GsnVTr/p3Cqs6WhXBIZleNIrnXCB20fc+hmsGYWsRMUA8iKN7UqvP+FCPlOlK1BI2TtyCBVRW5F+5I7Mn
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fd6ded-7eb4-4fb1-be52-08d81c213e3c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 11:40:38.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cliQFeglhMU9KFWNXUU9hwZ0n3rX5bx8xmenX8MU63sqmCqfQB9Sr6fnNnRPJjl5ynmHJuWoT4P2y2LZyijgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6210
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 25, 2020 at 10:29:15PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 25, 2020 at 2:06 PM kernel test robot <lkp@intel.com> wrote:
> 
> >     50          } else if (is_acpi_node(dev->parent->fwnode)) {
> 
> Hmm... Is it a device or data node?

Device node.

> 
> >     51                  device_for_each_child_node(dev->parent, dpmac) {
> >   > 52                          status = acpi_evaluate_integer(ACPI_HANDLE_FWNODE(dpmac),
> >     53                                                         "_ADR", NULL, &adr);
> >     54                          if (ACPI_FAILURE(status)) {
> >     55                                  dev_info(dev, "_ADR returned status 0x%x\n", status);
> >     56                                  continue;
> >     57                          } else {
> >     58                                  id = (u32)adr;
> >     59                                  if (id == dpmac_id)
> >     60                                          return dpmac;
> >     61                          }
> >     62                  }
> 
> Can't you use
> 
>  adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), dpmac_id, false);
>  if (adev)
>   return ...

Thanks. It looks better.
> 
> ?
> 
> >     63          }
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
