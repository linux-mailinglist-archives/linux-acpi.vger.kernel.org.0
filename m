Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F101E3A59
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392851AbfJXRrU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 13:47:20 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:49943
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391933AbfJXRrT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 13:47:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc2EMqVC23FBfv5pwihevy654CsQ6illwtz64SqTAsE2/07PZ1To2D+0ciM1QosAiJWizAgq2ABQLvdVMThp4Cg87odkOq+esUMk68ORN3mYkpDZcp+xCeuZhDEgePz7KoO8EtAb7TEEUWGzMUqW/0dULJmejEnB1LxKG8Ca1x3xqnbRAFpZaoXtK0J/8s6GH2N9A7u5yjXwYnEb3mY5tBNcQDshY+AAcWdkyD6wUunVWosynZQTxEaBgsxTFBDKIPK+Wh9PdG/D5W6sFn31vojkLf1n9znZZX/BLTq4L+ipjAqxggnqPRcDHeTr5VtRA+MReHVJkIFFH5d3R8L8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMhFnLvbHo7Y7UUhYOu5P3EqTr76XuBuDtbezEuSuWk=;
 b=Wxsvpec2OQMlzyH437B44qSQlMWuv8SF+kKCy8alc05gLq3MUAwqMqvhzkhRar62ZH8ulBYJeC826bGTDbOSG47e44l4yJsT2rPyecYetLmg8WNrSN8P+c36VTzT9CYUpaBEbtMvwL/CrWJEWWgkHYM9RYFyl68BluGJh40I5y7QBSfmmERlsiy/Fa/0cIlfKnp1u1yKO9ZIf7g1FKEVfZrVkND5M1/9NY6wIRpQXr5YWSX54uzdv75UywiH1BWZ+F7TOZu6hhsOdmd3RLcfXQiRyIThM+YBBimhIgLEmGJWSMTH2NDdFCDBz3SJARFFWzXhKeTrjJNQib88og5+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMhFnLvbHo7Y7UUhYOu5P3EqTr76XuBuDtbezEuSuWk=;
 b=Cv5iXDHHvTnhTu82smAu4NBqtig+MpNWVtP6JhhmTwIXfBzszknjhf6cqiGimc6r+Eez3Xf79rGmb5Nz7YuVJnX7Z/IQ2Nzhfiwwj0xm/27Tfn0hARS1GYc96+ypX63VfM3wWFCHoRTS1ifXJWR4fPhzMPdrTMXndcGFXB6KUw8=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4638.eurprd04.prod.outlook.com (20.177.56.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 17:47:14 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f%4]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 17:47:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Topic: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Index: AQHViSTjqsMfVqNAR0a2lS+zHVHmpw==
Date:   Thu, 24 Oct 2019 17:47:14 +0000
Message-ID: <VI1PR04MB7023C43A2E9B60A26B6DD0CCEE6A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com>
 <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0gWdFVbvPobLic7F+bRrz-QUoV3GPhpawdFT0MVjAhuOQ@mail.gmail.com>
 <AM7PR04MB7015D5B0C6952BF6B04C140CEE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
 <CAJZ5v0iY4QScdQJW4xzJEMcfxkB2QDjBkR2oo3zBRL7x70PmnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d166a81-43ed-423c-6d31-08d758aa34a2
x-ms-traffictypediagnostic: VI1PR04MB4638:|VI1PR04MB4638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4638B225A27727B5B92591DBEE6A0@VI1PR04MB4638.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(55016002)(9686003)(14454004)(6436002)(4326008)(6246003)(76176011)(54906003)(81156014)(8676002)(99286004)(7696005)(7736002)(74316002)(316002)(305945005)(478600001)(33656002)(66066001)(81166006)(8936002)(6916009)(4001150100001)(25786009)(476003)(76116006)(86362001)(66946007)(229853002)(91956017)(66446008)(64756008)(14444005)(256004)(486006)(52536014)(44832011)(3846002)(6116002)(66556008)(446003)(5660300002)(66476007)(71200400001)(71190400001)(6506007)(7416002)(186003)(26005)(53546011)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4638;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4E2HSO2OOHRqonBZLcNw0EdIPHcQG9TigwGjnEsJR9CgEgLbBL9ql3ETY7S8/52WD26lGNI+6+QTlT1OcNmA1zwezgpN7bjFnHJMkifOHagGyXuIHPZr6sfSUdO5TmGa6XNYqNbiJPdrurs37zqD7w3Eq4KcCIaJTGe8/jvbYrdH+3CUNZ91iVIl0fhcUc95STUFRHSyiSm885y4zqznEZyj1nZigoaRB7NgsQfdqBtBqASAPfg15HAOVu9aVVAw6sonHPvfMHmTMKTpef2HFSRXjGik8PPOw4cTA85VPmJwuA3hcRoIl0pnMv4zGPC++dpDtptcMEDMJr9OaJzva8xL5GYBykmP0fmB0n4vwCvp8++YYyVWbj5m7DtNrSa3UYv+k8Whfc4ycxgaIPt8r2FAdJGIfg6x5alJ4MmSvDRhtO2XeFtzldR/bZ45PemD
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d166a81-43ed-423c-6d31-08d758aa34a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 17:47:14.5226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9UC6RHnRMEceOZFZ7QW4LAFKVnwWmOw23Dtxt1rDExZlCOm9ACJKxa+Pf+lJ2eOyFvm1akQbC3sOQQLUbJujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4638
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24.10.2019 16:42, Rafael J. Wysocki wrote:=0A=
> On Wed, Oct 23, 2019 at 3:33 PM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>>=0A=
>> On 2019-10-23 11:54 AM, Rafael J. Wysocki wrote:=0A=
>>> On Wed, Oct 23, 2019 at 4:20 AM Leonard Crestez <leonard.crestez@nxp.co=
m> wrote:=0A=
>>>> On 2019-10-23 1:48 AM, Rafael J. Wysocki wrote:=0A=
> =0A=
> [cut]=0A=
> =0A=
>>>>> But combining the lists of requests for all the CPUs in a policy=0A=
>>>>> defeats the idea of automatic aggregation of requests which really is=
=0A=
>>>>> what PM QoS is about.=0A=
>>>>=0A=
>>>> My primary interest is the "dev" part of dev_pm_qos: making pm_qos=0A=
>>>> requests tied to a specific device.=0A=
>>>=0A=
>>> The list of requests needs to be associated with the user of the=0A=
>>> effective constraint.  If that is the device, it is all good.=0A=
>>=0A=
>> The phrase "user of the effective constraint" is somewhat unclear.=0A=
> =0A=
> Fair enough, so let me elaborate.=0A=
> =0A=
> The effective constraint (ie. the one resulting from taking all of the=0A=
> requests in the relevant QoS list into account) affects the selection=0A=
> of an OPP, so it is natural to associate the QoS list producing it=0A=
> with a list of OPPs to select.  In the cpufreq case, the policy holds=0A=
> the list of OPPs and so it also should hold the corresponding QoS=0A=
> lists (for the min and max frequency limits).  It "uses" the effective=0A=
> constraints produced by those QoS lists by preventing the OPPs out of=0A=
> the between the min and max values  from being selected.=0A=
> =0A=
> Essentially, the policy represents a power (clock/voltage) domain with=0A=
> multiple components (it doesn't matter what they are at this level of=0A=
> abstraction). While there can be multiple sources of QoS requests=0A=
> associated with each component, all of these requests ultimately need=0A=
> to be passed to the domain for aggregation, because that's where the=0A=
> frequency selection decisions are made and so that's where the=0A=
> effective constraint value needs to be known. Now, the natural way to=0A=
> allow requests from multiple sources to be passed for aggregation is=0A=
> to provide a QoS list that they can be added to. That really is what=0A=
> PM QoS is for.=0A=
> =0A=
>> I'm using the target device as dev for dev_pm_qos, not the requestor.=0A=
>> This is consistent with how it was used for cpufreq: thermal called a=0A=
>> dev_pm_qos_add_request on with dev =3D cpu_dev not a thermal sensor or=
=0A=
>> anything else.=0A=
> =0A=
> Not really, but close. :-)=0A=
> =0A=
> Without my series (that is 5.4-rc4, say), the cpu_cooling driver adds=0A=
> its constraint to the device PM QoS of cpufreq_cdev which is a special=0A=
> device created by that driver.  That would be fine, except that the=0A=
> cpufreq core doesn't use that QoS.  It uses the device PM QoS of the=0A=
> policy->cpu device instead.  That is, that's where it adds its=0A=
> notifiers (see cpufreq_policy_alloc()), that's where user space=0A=
> requests are added (see cpufreq_online()), and (most important) that's=0A=
> where the effective constraint value is read from (see=0A=
> cpufreq_set_policy()).  That turns out to be problematic (in addition=0A=
> to the cpu_cooling driver's QoS requests going nowhere), because=0A=
> confusion ensues if the current policy->cpu goes away.=0A=
=0A=
That behavior in cpu_cooling seems like a bug.=0A=
=0A=
>> However looking at other dev_pm_qos users there are instances of a=0A=
>> driver calling dev_pm_qos_add_request on it's own device but this is not=
=0A=
>> a strict requirement, correct?=0A=
> =0A=
> No, it isn't.=0A=
> =0A=
>>>>> There have to be two lists of requests per policy, one for the max an=
d=0A=
>>>>> one for the min frequency >=0A=
>>>>>> If cpufreq needs a group of CPUs to run at the same frequency then i=
t=0A=
>>>>>> should deal with this by doing dev_pm_qos_read_frequency on each CPU=
=0A=
>>>>>> device and picking a frequency that attempts to satisfy all constrai=
nts.=0A=
>>>>>=0A=
>>>>> No, that would be combining the requests by hand.=0A=
>>>>=0A=
>>>> It's just a loop though.=0A=
>>>=0A=
>>> Yes, it is, and needs to be run on every change of an effective=0A=
>>> constraint for any CPU even if the total effective constraint doesn't=
=0A=
>>> change.  And, of course, the per-policy user space limits would need=0A=
>>> to be combined with that by hand.=0A=
>>>=0A=
>>> Not particularly straightforward if you asked me.=0A=
>>=0A=
>> Well, this cpu-to-policy aggregation could also use a pm_qos_constraint=
=0A=
>> object instead of looping.=0A=
> =0A=
> Yes, it could, but then somebody would need to add those=0A=
> "intermediate" requests to a proper policy-level QoS and it would need=0A=
> an extra notifier invocation to update each of them on a "component"=0A=
> QoS change.=0A=
> =0A=
> This is an interesting idea in case we ever need to improve the=0A=
> scalability of the QoS lists, but I'd rather use the simpler approach=0A=
> for now.=0A=
=0A=
The advantage I see is reducing the exposure of cpufreq internals=0A=
=0A=
>>>>> Well, the cpufreq sysfs is per-policy and not per-CPU and we really=
=0A=
>>>>> need a per-policy min and max frequency in cpufreq, for governors etc=
.=0A=
>>>>=0A=
>>>> Aggregation could be performed at two levels:=0A=
>>>>=0A=
>>>> 1) Per cpu device (by dev_pm_qos)=0A=
>>>> 2) Per policy (inside cpufreq)=0A=
>>>>=0A=
>>>> The per-cpu dev_pm_qos notifier would just update a per-policy=0A=
>>>> pm_qos_constraints object. The second step could even be done strictly=
=0A=
>>>> inside the cpufreq core using existing pm_qos, no need to invent new=
=0A=
>>>> frameworks.=0A=
>>>>=0A=
>>>> Maybe dev_pm_qos is not a very good fit for cpufreq because of these=
=0A=
>>>> "cpu device versus cpufreq_policy" issues but it makes a ton of sense=
=0A=
>>>> for devfreq. Can you maybe hold PATCH 3 from this series pending furth=
er=0A=
>>>> discussion?=0A=
>>>=0A=
>>> It can be reverted at any time if need be and in 5.4 that would be dead=
 code.=0A=
>>=0A=
>> I guess I can post v10 of my "devfreq pm qos" which starts by reverting=
=0A=
>> "PATCH 3" of this series?=0A=
> =0A=
> You may do that, but I would consider adding a struct freq_constraints=0A=
> pointer directly to struct dev_pm_info and using the new frequency QoS=0A=
> helpers to manage it.=0A=
> =0A=
> Arguably, there is no need to bundle that with the rest of device PM=0A=
> QoS and doing the above would help to avoid some code duplication too.=0A=
=0A=
Adding to struct dev_pm_info would increase sizeof(struct device) while =0A=
dev_pm_qos only allocates memory when constraints are added. My =0A=
expectation is that very few devices would even have min_freq and =0A=
max_freq constraints.=0A=
=0A=
Maybe struct dev_pm_qos could host a "struct freq_constraints freq" =0A=
instead of two separate "struct pm_qos_constraints min/max_frequency"? =0A=
This way there would be two users of freq_constraints: cpufreq_policy =0A=
(which is not a device) and dev_pm_qos.=0A=
=0A=
In the future freq_constraints might be extended to implement some logic =
=0A=
for conflicts between min_freq and max_freq requests.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
