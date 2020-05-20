Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5061DBAB8
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 19:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgETRH3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 13:07:29 -0400
Received: from mail-dm6nam10on2120.outbound.protection.outlook.com ([40.107.93.120]:49794
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgETRH1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 13:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0HCSpgrK+68ZSiswU/fdec4vOJwM0mGaXEOAbvQtrtsTQ/ijbHIbd6Xv5YWBC3Lmw8NzOXbQvNtEjwT8mU4Tk/9BGn0EnJ8ONKBr3vzjAJNQZikcLfmV9n0nE/NWnFzf7fNgxCOi/Oj2bvVbRGLZk5iFYKLrrlWrTq8aFd6fO96irqN4QoNtH1wDYteok2yc9YIkpxOFg3DnE8r4R/IMK+Op9kCxRaf9b1oAFvKDhOGYRjq40mSxmNED9Q0J5ErzeuvurNRV36hljINgqeCO5Djt4ZOj8uvVlEbk4h02VCT62jmQDYTpKKPNE06jUg/el9OFSKkVsw1OwCC7yyk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3V6RW2/XmGVDfQ6ppSq2c4K8yONJAlNKKJ0Qme3URA=;
 b=FlzDAJPxwcQItwUEflPH0thDHuv7jeWb9jw4wf2hhiGvM+Cdgc3ig7AxuSeKW0yhgKSyxtHcND6aI/4/FjY6CCNAQnKoAKwPdGgBM8hYBMySQwAVEbTPVAMxFy3/cgEygxhHqu1OC9SEEE1EJgf1dpV7d/HwITUNNHa2pFcq0WpdnOoZSwLJAgEHgcdFNUfcleVpcuhj03d7BCLMBlRjObZ0wnV32WgZ6Uq5TgqhcvKxXbO3fn7elpXEVhNq2r1XcnqWnGjIJObJ2iNAUWIRCmo9qR4vVB8hR9QMtSKzsSyQTaFYeKm6eksGGNag60vzQJ7lXEmslRyqT+serDJeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3V6RW2/XmGVDfQ6ppSq2c4K8yONJAlNKKJ0Qme3URA=;
 b=dijmMUE/Ezu8dr3x8/9U0Kg3is5N92YZFQqKxjIFIC17On/DUyg1LCMtxhdgt3ABzVHoSHcECtU0bZ3/+6anp3Q2CUpl4zLL0n1YZxXeB2pNM8PBpT0WdnTR8vcLgL574Zo9guAHq/MQoy88edBd7FgyoUmxyXsBm7WpFCPMVsE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4808.prod.exchangelabs.com (2603:10b6:a03:85::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Wed, 20 May 2020 17:07:25 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::296c:b848:8bf0:6f2c%5]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 17:07:25 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH v4] ACPI/IORT: Fix PMCG node single ID mapping handling.
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <20200520125813.GA6906@e121166-lin.cambridge.arm.com>
Date:   Wed, 20 May 2020 10:07:20 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        patches@amperecomputing.com, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C9161BC-A333-4AF4-B277-D8BC64A3F1B9@amperemail.onmicrosoft.com>
References: <1589570686-5780-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200520125813.GA6906@e121166-lin.cambridge.arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-ClientProxiedBy: CY4PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:903:152::33) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.173] (73.151.56.145) by CY4PR13CA0095.namprd13.prod.outlook.com (2603:10b6:903:152::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.7 via Frontend Transport; Wed, 20 May 2020 17:07:22 +0000
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Originating-IP: [73.151.56.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f422575c-82e8-4995-0004-08d7fce04450
X-MS-TrafficTypeDiagnostic: BYAPR01MB4808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB4808C1EFB0B3C539D80D7980E0B60@BYAPR01MB4808.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z95Ijfg0wpLDueTfXhjcgg6Ird/EeKK1WfIfpsZafC98GhghFHUepYlx7kefYkx83tgh1kjWMLS2VbNr5vt4fW66TZsTB/nlisLHLC4xaims1eEpEyrBJNXkd098Ld6BqDpq8EffFGH94+c+b+RQZ3/h/wQDKQqU44RUjFbv+Jv2iU3QOT4c22kUujTB8U9ZEu1hRxzvYCKDmw53T3EPfDgHQ7b/qj8XdxWHo9Iny+c+eBbDplCg3ITbpqpD7O6HHTgNO+IEjoOH4oRZlazfQu1BjWNDQpSUsIqr4r7BCszQJaYrcCzDgyrgFUiukeUdgREZmx09aFXgHCsWKXqReA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(346002)(396003)(366004)(376002)(136003)(16576012)(42882007)(316002)(54906003)(2906002)(66476007)(4326008)(53546011)(5660300002)(26005)(33656002)(66556008)(16526019)(66946007)(52116002)(186003)(956004)(2616005)(83170400001)(8936002)(478600001)(8676002)(6486002)(7416002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /PrF1DLYHIz6/bwG1vx/A4b1FACxLaQCYwNGO62sxWFhxKnpIFaRMr5uxIZLFb/8rRqCshPSyfu/MVDKPSFZGy7UtyX1JBD1pOV8f5zJRJjmiBkgsZP2bREVEQanPu3c6fPr/XsY+X11BbeL+hcMh3Bme7WEYcmL88J5iBGGEUUWgv4e0FsfcNyJOPQM2kLGE3+gbsapDxLewap0BWD38GGOgdAaagN9EEqV+toSsA073njFR3nXGwvA8JK34uQEFaSiPl7N29K4hzhK5/p4lagW6YvwQWPVy21FkAkZGJrwjdbbXIF6sqoO5W18xAQ1j8tr+xX+0yT+MUSauTvWl5UfO3BSP3IWsYw4YWTTLxIFGx6817PxxyXCUwntPzdoSv5kTeDlLvDI84arvUqMKF2JFyBZ+d4LZYpkVKq8IS52hMZvvZkfHwaj9rYwFdODaje4ykdG98gSJvVyx42LA0O5YcZI2X9VcAJQ9nIoIJo=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f422575c-82e8-4995-0004-08d7fce04450
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 17:07:24.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56mvDkHVIKmlH+dSB7w+cvmE9EnldrVJn1CQJTWzvj7rzZtn8NJKJ1FwxUbJ7p3nOofk0DB7uoqNHdfR881y/U92B06o86psHh8lM+IuB6+tAgA+P8ghUDG7g8BrlNgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4808
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> On May 20, 2020, at 5:58 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com=
> wrote:
>=20
> On Fri, May 15, 2020 at 12:24:46PM -0700, Tuan Phan wrote:
>> An IORT PMCG node can have no ID mapping if its overflow interrupt is
>> wire based therefore the code that parses the PMCG node can not assume
>> the node will always have a single mapping present at index 0.
>>=20
>> Fix iort_get_id_mapping_index() by checking for an overflow interrupt
>> and mapping count.
>>=20
>> Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG").
>=20
> Remove these periods in the $SUBJECT and commit references, I
> don't know why you keep adding them.
>=20
> Anyway - I don't know if it is too late for v5.8 but this patch
> is ready to be merged (minus the nits I have just mentioned).

Thanks, will fix it.
>=20
> Lorenzo
>=20
>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>> v1 -> v2:
>> - Use pmcg node to detect wired base overflow interrupt.
>>=20
>> v2 -> v3:
>> - Address Hanjun and Robin's comments.
>>=20
>> v3 -> v4:
>> - Update the title and description as mentioned by Lorenzo.
>>=20
>> drivers/acpi/arm64/iort.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index ed3d2d1..12bb70e 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -414,6 +414,7 @@ static struct acpi_iort_node *iort_node_get_id(struc=
t acpi_iort_node *node,
>> static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>> {
>> 	struct acpi_iort_smmu_v3 *smmu;
>> +	struct acpi_iort_pmcg *pmcg;
>>=20
>> 	switch (node->type) {
>> 	case ACPI_IORT_NODE_SMMU_V3:
>> @@ -441,6 +442,10 @@ static int iort_get_id_mapping_index(struct acpi_io=
rt_node *node)
>>=20
>> 		return smmu->id_mapping_index;
>> 	case ACPI_IORT_NODE_PMCG:
>> +		pmcg =3D (struct acpi_iort_pmcg *)node->node_data;
>> +		if (pmcg->overflow_gsiv || node->mapping_count =3D=3D 0)
>> +			return -EINVAL;
>> +
>> 		return 0;
>> 	default:
>> 		return -EINVAL;
>> --=20
>> 2.7.4
>>=20

